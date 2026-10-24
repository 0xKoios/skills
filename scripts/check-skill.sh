#!/usr/bin/env bash
# Structure check: skill frontmatter, file references, one SKILL.md per folder.
# Usage: scripts/check-skill.sh   (run from anywhere; exits 1 on any error)
set -u
cd "$(dirname "$0")/.."
errors=0
SKILLS_DIR="${SKILLS_DIR:-skills}"
fail() { echo "ERROR: $*"; errors=$((errors + 1)); }

for skill_md in "$SKILLS_DIR"/*/SKILL.md; do
  dir=$(dirname "$skill_md")
  dir_name=$(basename "$dir")

  # Frontmatter: first line ---, then name and description before the closing ---
  [ "$(head -n 1 "$skill_md")" = "---" ] || fail "$skill_md: must start with --- frontmatter"
  front=$(awk 'NR==1{next} /^---$/{exit} {print}' "$skill_md")
  name=$(printf '%s\n' "$front" | sed -n 's/^name:[[:space:]]*//p')
  desc=$(printf '%s\n' "$front" | sed -n 's/^description:[[:space:]]*//p')
  [ "$name" = "$dir_name" ] || fail "$skill_md: name '$name' must match folder '$dir_name'"
  printf '%s' "$name" | grep -Eq '^[a-z0-9-]{1,64}$' || fail "$skill_md: name must be lowercase letters, digits, hyphens (max 64)"
  [ -n "$desc" ] || fail "$skill_md: description is missing"
  [ "${#desc}" -le 1024 ] || fail "$skill_md: description is ${#desc} chars (max 1024)"

  # Invocation: principles and the supervisor are only run on request
  case "$dir_name" in
    principle-*|supervisor|supervisor-*)
      printf '%s\n' "$front" | grep -Eq '^disable-model-invocation:[[:space:]]*true[[:space:]]*$' || \
        fail "$skill_md: needs disable-model-invocation: true"
      ;;
  esac

  # evals/evals.json (optional): schema documented in the supervisor plan
  evals="$dir/evals/evals.json"
  if [ -f "$evals" ]; then
    if ! command -v jq >/dev/null 2>&1; then
      fail "$evals: jq is required to check evals.json"
    elif ! jq -e . "$evals" >/dev/null 2>&1; then
      fail "$evals: invalid JSON"
    else
      while IFS= read -r msg; do
        fail "$evals: $msg"
      done < <(jq -r --arg skill "$dir_name" '
        (if .skill_name == $skill then empty else "skill_name '"'"'\(.skill_name)'"'"' must be '"'"'\($skill)'"'"'" end),
        ((.evals // []) | group_by(.id)[] | select(length > 1) | "duplicate id '"'"'\(.[0].id)'"'"'"),
        ((.evals // [])[] | .id as $id
          | (if ((.checks // []) | length) + ((.assertions // []) | length) == 0
             then "eval '"'"'\(.id)'"'"' needs checks or assertions" else empty end),
            ((.checks // [])[] | select(.type != "output_matches" and .type != "output_not_matches")
             | "eval '"'"'\($id)'"'"' check type '"'"'\(.type)'"'"' unknown"))
      ' "$evals")
      # Files are listed per eval; check each exists relative to the skill dir
      while IFS=$'\t' read -r id f; do
        [ -e "$dir/$f" ] || fail "$evals: eval '$id' file $f not found"
      done < <(jq -r '(.evals // [])[] | .id as $id | (.files // [])[] | [$id, .] | @tsv' "$evals")
    fi
  fi

  # Every `something.md` in backticks must exist, relative to the file that mentions it
  while read -r file; do
    while read -r ref; do
      [ -f "$(dirname "$file")/$ref" ] || fail "$file: references missing file $ref"
    done < <(grep -oE '`[A-Za-z0-9_./-]+\.md`' "$file" | tr -d '`' | sort -u)
  done < <(find "$dir" -name '*.md')
done

# Every folder in skills/ must be a skill (exact name SKILL.md)
for dir in "$SKILLS_DIR"/*/; do
  # ls + exact match, because [ -f ] ignores case on macOS
  ls "$dir" | grep -qx 'SKILL.md' || fail "${dir}: missing SKILL.md (exact name, uppercase)"
done

# ado-boards: split az recipes (cheaper context); no monolithic commands.md
if [ -d "$SKILLS_DIR/ado-boards" ]; then
  ado="$SKILLS_DIR/ado-boards"
  for f in README.md setup.md my-cards.md create.md comments.md plan-my-sprint.md write-description.md windows.md; do
    [ -f "$ado/az/$f" ] || fail "$ado/az/$f: missing (az recipe split)"
  done
  [ ! -e "$ado/commands.md" ] || fail "$ado/commands.md: must not exist after az/ split"
  if [ -f "$ado/az/my-cards.md" ]; then
    grep -q 'commentId' "$ado/az/my-cards.md" && fail "$ado/az/my-cards.md: must not contain commentId (belongs in az/comments.md)"
    grep -q '@desc.html' "$ado/az/my-cards.md" && fail "$ado/az/my-cards.md: must not contain @desc.html (belongs in az/windows.md)"
  fi
  for wf in "$ado"/workflows/*.md; do
    head -n 5 "$wf" | grep -q '`\.\./az/' || fail "$wf: first paragraph must reference \`../az/\` for az backend"
  done
  # SKILL.md must not load az/windows.md on every Windows az turn (only HTML/quoting failures)
  while IFS= read -r line; do
    case "$line" in
      *az/windows.md*)
        printf '%s' "$line" | grep -Eqi 'only when' || \
          fail "$ado/SKILL.md: az/windows.md mention must say \"only when\" (scoped), not every Windows turn"
        ;;
    esac
  done < "$ado/SKILL.md"
fi

if [ "$errors" -gt 0 ]; then
  echo "$errors error(s)"
  exit 1
fi
echo "OK: all skill checks passed"
