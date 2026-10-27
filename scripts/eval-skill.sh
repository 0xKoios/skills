#!/usr/bin/env bash
# Run a skill's evals/evals.json against an agent and report pass counts.
# Usage: scripts/eval-skill.sh <skill> <agent> [--case <id>] [--trials N] [--baseline] [--grader <agent>]
#   <agent>: claude | cursor | copilot | stub
# Env: SKILLS_DIR (default <repo>/skills), EVAL_OUT_DIR (default mktemp -d), EVAL_STUB_CMD (stub agent)
# Exit: 0 every case passes a majority of trials, 1 a case fails, 2 usage error.
set -u
here="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="${SKILLS_DIR:-$here/../skills}"
EVAL_OUT_DIR="${EVAL_OUT_DIR:-$(mktemp -d)}"
grader_tpl="$here/eval-grader.md"

usage() { echo "usage: eval-skill.sh <skill> <agent> [--case <id>] [--trials N] [--baseline] [--grader <agent>]" >&2; exit 2; }

# cli_for <agent>: the CLI binary an agent needs on PATH (empty for stub).
cli_for() {
  case "$1" in
    claude) echo claude ;;
    cursor) echo cursor-agent ;;
    copilot) echo copilot ;;
  esac
}

# skill_dir_for <agent>: workspace-relative dir where the agent discovers skills.
skill_dir_for() {
  case "$1" in
    stub) echo ".agents/skills" ;;
    claude) echo ".claude/skills" ;;
    cursor) echo ".cursor/skills" ;;
    copilot) echo ".github/skills" ;;
    *) echo "agent $1 not implemented yet" >&2; return 1 ;;
  esac
}

# run_agent <agent> <workspace> <prompt-file> <out-file> [grade]: run the agent, write its reply to out-file.
# Edits stay in the workspace and git is read-only. With "grade", the agent gets no tools.
# Returns nonzero on failure (callers record a failure reason).
run_agent() {
  local agent="$1" ws="$2" prompt="$3" outf="$4" mode="${5:-}"
  case "$agent" in
    stub)
      [ -n "${EVAL_STUB_CMD:-}" ] || { echo "EVAL_STUB_CMD is not set" >&2; return 1; }
      "$EVAL_STUB_CMD" "$ws" "$prompt" > "$outf" ;;
    claude)
      if [ "$mode" = grade ]; then
        (cd "$ws" && claude -p "$(cat "$prompt")" --output-format text --tools "") > "$outf"
      else
        (cd "$ws" && claude -p "$(cat "$prompt")" --output-format text \
          --allowedTools "Read" "Glob" "Grep" "Edit(./**)" "Bash(python3 *)" \
          "Bash(git status *)" "Bash(git diff *)" "Bash(git log *)" "Bash(git show *)") > "$outf"
      fi ;;
    cursor)
      if [ "$mode" = grade ]; then
        cursor-agent -p --trust --mode ask --workspace "$ws" --output-format text "$(cat "$prompt")" > "$outf"
      else
        cursor-agent -p --trust --workspace "$ws" --output-format text "$(cat "$prompt")" > "$outf"
      fi ;;
    copilot)
      if [ "$mode" = grade ]; then
        (cd "$ws" && copilot -p "$(cat "$prompt")" -s --no-ask-user) > "$outf"
      else
        (cd "$ws" && copilot -p "$(cat "$prompt")" -s --no-ask-user \
          --allow-tool='write, shell(python3:*), shell(git status), shell(git diff), shell(git log), shell(git show)') > "$outf"
      fi ;;
    *) echo "agent $agent not implemented yet" >&2; return 1 ;;
  esac
}

skill="" agent="" only_case="" trials=3 baseline=0 grader=""
pos=0
while [ $# -gt 0 ]; do
  case "$1" in
    --case) [ $# -ge 2 ] || usage; only_case="$2"; shift 2 ;;
    --trials) [ $# -ge 2 ] || usage; trials="$2"; shift 2 ;;
    --grader) [ $# -ge 2 ] || usage; grader="$2"; shift 2 ;;
    --baseline) baseline=1; shift ;;
    -*) usage ;;
    *) pos=$((pos + 1)); [ "$pos" -eq 1 ] && skill="$1"; [ "$pos" -eq 2 ] && agent="$1"; [ "$pos" -gt 2 ] && usage; shift ;;
  esac
done
[ -n "$skill" ] && [ -n "$agent" ] || usage
case "$trials" in ''|*[!0-9]*|0) usage ;; esac
grader="${grader:-$agent}"
for a in "$agent" "$grader"; do
  case "$a" in claude|cursor|copilot|stub) ;; *) echo "unknown agent: $a" >&2; exit 2 ;; esac
done
command -v jq >/dev/null 2>&1 || { echo "jq is required" >&2; exit 2; }
for a in "$agent" "$grader"; do
  cli=$(cli_for "$a")
  [ -z "$cli" ] || command -v "$cli" >/dev/null 2>&1 || { echo "$cli not installed" >&2; exit 2; }
done

skill_path="$SKILLS_DIR/$skill"
evals_json="$skill_path/evals/evals.json"
[ -f "$evals_json" ] || { echo "no evals.json for $skill: $evals_json" >&2; exit 2; }
jq -e '.evals | type == "array" and length > 0' "$evals_json" >/dev/null 2>&1 || {
  echo "evals.json needs a non-empty .evals array: $evals_json" >&2; exit 2; }
if [ -n "$only_case" ] && ! jq -e --arg id "$only_case" '.evals[] | select(.id == $id)' "$evals_json" >/dev/null; then
  echo "no case: $only_case" >&2; exit 2
fi

echo "$skill via $agent ($trials trials, outputs in $EVAL_OUT_DIR)"
for d in "$HOME/.claude/skills" "$HOME/.agents/skills" "$HOME/.cursor/skills" "$HOME/.copilot/skills"; do
  [ -d "$d" ] && echo "warning: global skills dir exists, baseline is not skill-free: $d"
done

# install_skills <workspace>: copy the skill and its `install` extras into the agent's skills dir.
install_skills() {
  local dest pat f
  dest="$1/$(skill_dir_for "$agent")" || return 1
  mkdir -p "$dest"
  cp -R "$skill_path" "$dest/"
  while IFS= read -r pat; do
    [ -n "$pat" ] || continue
    for f in "$SKILLS_DIR"/$pat; do [ -d "$f" ] && cp -R "$f" "$dest/"; done
  done < <(jq -r '.install[]?' "$evals_json")
}

# grade <output-file> <assertions-json> <prompt-file> <grader-workspace> <grader-out-file>:
# echoes a failure reason, or nothing if all pass. The grader workspace is fresh and empty.
grade() {
  local outf="$1" assertions="$2" gprompt="$3" gws="$4" gouts="$5" tpl head tail list prompt gout json verdict
  tpl=$(<"$grader_tpl")
  list=$(printf '%s' "$assertions" | jq -r '.[] | "- " + .')
  head="${tpl%%'{{OUTPUT}}'*}"
  tail="${tpl#*'{{OUTPUT}}'}"
  prompt="$head$(<"$outf")$tail"
  head="${prompt%%'{{ASSERTIONS}}'*}"
  tail="${prompt#*'{{ASSERTIONS}}'}"
  printf '%s' "$head$list$tail" > "$gprompt"
  rm -rf "$gws"; mkdir -p "$gws"
  run_agent "$grader" "$gws" "$gprompt" "$gouts" grade </dev/null || { echo "grader run failed"; return; }
  gout=$(<"$gouts")
  json="${gout#*\{}"
  if [ "$json" = "$gout" ]; then echo "grader output unparsable"; return; fi
  json="{${json%\}*}}"
  if ! printf '%s' "$json" | jq -e '.results | type == "array" and all(type == "object")' >/dev/null 2>&1; then
    echo "grader output unparsable"; return
  fi
  verdict=$(printf '%s' "$json" | jq -r --argjson want "$assertions" '
    . as $g
    | [$want[] as $a | ($g.results | map(select(.assertion == $a)) | first) as $r
       | if $r == null or $r.passed != true then "assertion failed: " + $a else empty end]
    | first // empty') || { echo "grader output unparsable"; return; }
  printf '%s' "$verdict"
}

# run_trial <id> <with|without> <n>: echoes a failure reason, or nothing if the trial passes.
run_trial() {
  local id="$1" mode="$2" n="$3" ws promptf outf reason t pat ty f line
  ws="$EVAL_OUT_DIR/$id/$mode/trial-$n"
  rm -rf "$ws"; mkdir -p "$ws"
  if [ "$mode" = with ]; then install_skills "$ws" || { echo "skill install failed"; return; }; fi
  while IFS= read -r f; do
    [ -n "$f" ] && cp "$skill_path/$f" "$ws/$(basename "$f")"
  done < <(jq -r --arg id "$id" '.evals[] | select(.id == $id) | .files[]?' "$evals_json")
  promptf="$ws.prompt.txt"; outf="$ws.out.txt"
  jq -j --arg id "$id" '.evals[] | select(.id == $id) | .prompt' "$evals_json" > "$promptf"
  run_agent "$agent" "$ws" "$promptf" "$outf" </dev/null || { echo "agent run failed"; return; }
  # \001 separator: unlike @tsv it leaves regex backslashes intact.
  while IFS= read -r line; do
    [ -n "$line" ] || continue
    ty="${line%%$'\001'*}"; pat="${line#*$'\001'}"
    if [ "$ty" = output_matches ]; then
      grep -Eq -- "$pat" "$outf" || { echo "output_matches $pat"; return; }
    else
      ! grep -Eq -- "$pat" "$outf" || { echo "output_not_matches $pat"; return; }
    fi
  done < <(jq -r --arg id "$id" '.evals[] | select(.id == $id) | .checks[]? | [.type, .pattern] | join("\u0001")' "$evals_json")
  t=$(jq -c --arg id "$id" '.evals[] | select(.id == $id) | .assertions // []' "$evals_json")
  if [ "$t" != "[]" ]; then
    reason=$(grade "$outf" "$t" "$ws.grader-prompt.txt" "$EVAL_OUT_DIR/$id/grader/$mode-trial-$n" "$ws.grader-out.txt")
    [ -z "$reason" ] || { echo "$reason"; return; }
  fi
}

# run_mode <id> <with|without>: sets $passes and $first_reason.
run_mode() {
  local id="$1" mode="$2" n r
  passes=0; first_reason=""
  for n in $(seq 1 "$trials"); do
    r=$(run_trial "$id" "$mode" "$n")
    if [ -z "$r" ]; then passes=$((passes + 1)); elif [ -z "$first_reason" ]; then first_reason="$r"; fi
  done
}

status=0
while IFS= read -r id; do
  [ -n "$only_case" ] && [ "$id" != "$only_case" ] && continue
  run_mode "$id" with
  if [ $((passes * 2)) -gt "$trials" ]; then
    echo "PASS $passes/$trials  $id"
  else
    echo "FAIL $passes/$trials  $id  [$first_reason]"; status=1
  fi
  if [ "$baseline" -eq 1 ]; then
    run_mode "$id" without
    echo "baseline $passes/$trials  $id"
  fi
done < <(jq -r '.evals[].id' "$evals_json")
exit "$status"
