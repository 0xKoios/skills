#!/usr/bin/env bash
# Tests for scripts/eval-skill.sh, run against the fixture skill with a stub agent.
# Usage: bash scripts/tests/eval-skill.test.sh   (exits 1 if any test fails)
set -u
here="$(cd "$(dirname "$0")" && pwd)"
runner="$here/../eval-skill.sh"
F="$here/fixtures/eval"
passed=0
failed=0

# run_eval <args...>: sets $out and $code
run_eval() {
  out=$(SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" EVAL_STUB_CMD="$F/stub-agent.sh" bash "$runner" "$@" 2>&1)
  code=$?
}
expect() {
  if [ "$2" -eq 0 ]; then
    passed=$((passed + 1)); echo "PASS: $1"
  else
    failed=$((failed + 1)); echo "FAIL: $1 ($3)"; printf '%s\n' "$out" | sed 's/^/    /'
  fi
}
contains() { printf '%s\n' "$out" | grep -qF -- "$1"; }

t_case_passes() {
  run_eval demo stub --case says-ok --trials 1
  local ok=0
  [ "$code" -eq 0 ] || ok=1
  contains "PASS 1/1  says-ok" || ok=1
  expect case_passes "$ok" "got exit $code"
}

t_case_fails() {
  run_eval demo stub --case impossible --trials 1
  local ok=0
  [ "$code" -eq 1 ] || ok=1
  contains "FAIL 0/1  impossible  [output_matches NEVER-PRINTED]" || ok=1
  expect case_fails "$ok" "got exit $code"
}

t_majority_rule() {
  run_eval demo stub --trials 1
  expect majority_rule "$([ "$code" -eq 1 ] && echo 0 || echo 1)" "expected exit 1, got $code"
}

t_baseline_runs_without() {
  run_eval demo stub --case says-ok --trials 1 --baseline
  expect baseline_runs_without "$(contains "baseline 0/1  says-ok" && echo 0 || echo 1)" "missing baseline line"
}

t_prompt_is_passed_verbatim() {
  local log want
  log=$(mktemp); want=$(mktemp)
  out=$(STUB_LOG="$log" SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" EVAL_STUB_CMD="$F/stub-agent.sh" bash "$runner" demo stub --case quoted --trials 1 2>&1)
  code=$?
  printf '%s' "it's \"\$HOME\" \`x\`"$'\n'"end" > "$want"
  expect prompt_is_passed_verbatim "$(cmp -s "$log" "$want" && echo 0 || echo 1)" "stub log differs from fixture prompt"
}

t_grader_garbage_fails_trial() {
  out=$(STUB_GRADER_GARBAGE=1 SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" EVAL_STUB_CMD="$F/stub-agent.sh" bash "$runner" demo stub --case says-ok --trials 1 2>&1)
  code=$?
  local ok=0
  [ "$code" -eq 1 ] || ok=1
  contains "grader output unparsable" || ok=1
  expect grader_garbage_fails_trial "$ok" "got exit $code"
}

t_unknown_agent_exits_2() {
  run_eval demo nope
  local ok=0
  [ "$code" -eq 2 ] || ok=1
  contains "unknown agent: nope" || ok=1
  expect unknown_agent_exits_2 "$ok" "got exit $code"
}

t_unknown_case_exits_2() {
  run_eval demo stub --case zzz
  local ok=0
  [ "$code" -eq 2 ] || ok=1
  contains "no case: zzz" || ok=1
  expect unknown_case_exits_2 "$ok" "got exit $code"
}

t_warns_global_skill_dirs() {
  local h; h=$(mktemp -d); mkdir -p "$h/.claude/skills"
  out=$(HOME="$h" SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" EVAL_STUB_CMD="$F/stub-agent.sh" bash "$runner" demo stub --case says-ok --trials 1 2>&1)
  code=$?
  expect warns_global_skill_dirs "$(contains "warning: global skills dir exists, baseline is not skill-free: $h/.claude/skills" && echo 0 || echo 1)" "missing warning"
}

t_regex_backslash_survives() {
  run_eval demo stub --case escaped --trials 1
  expect regex_backslash_survives "$([ "$code" -eq 0 ] && echo 0 || echo 1)" "got exit $code"
}

t_missing_cli_exits_2() {
  local bin; bin=$(mktemp -d)
  for c in jq mktemp dirname; do ln -s "$(command -v $c)" "$bin/$c"; done
  out=$(PATH="$bin" SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" /bin/bash "$runner" demo cursor --case says-ok --trials 1 2>&1)
  code=$?
  local ok=0
  [ "$code" -eq 2 ] || ok=1
  contains "cursor-agent not installed" || ok=1
  expect missing_cli_exits_2 "$ok" "got exit $code"
}

t_failed_assertion_fails_trial() {
  out=$(STUB_AGENT_SILENT=1 SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" EVAL_STUB_CMD="$F/stub-agent.sh" bash "$runner" demo stub --case assert-only --trials 1 2>&1)
  code=$?
  local ok=0
  [ "$code" -eq 1 ] || ok=1
  contains "FAIL 0/1  assert-only  [assertion failed: Says DEMO-OK]" || ok=1
  expect failed_assertion_fails_trial "$ok" "got exit $code"
}

t_malformed_json_exits_2() {
  run_eval malformed stub --trials 1
  local ok=0
  [ "$code" -eq 2 ] || ok=1
  contains "evals.json needs a non-empty .evals array" || ok=1
  expect malformed_json_exits_2 "$ok" "got exit $code"
}

t_object_evals_exits_2() {
  run_eval object-evals stub --trials 1
  local ok=0
  [ "$code" -eq 2 ] || ok=1
  contains "evals.json needs a non-empty .evals array" || ok=1
  expect object_evals_exits_2 "$ok" "got exit $code"
}

t_missing_jq_exits_2() {
  local bin; bin=$(mktemp -d)
  for c in mktemp dirname; do ln -s "$(command -v $c)" "$bin/$c"; done
  out=$(PATH="$bin" SKILLS_DIR="$F/skills" EVAL_OUT_DIR="$(mktemp -d)" EVAL_STUB_CMD="$F/stub-agent.sh" /bin/bash "$runner" demo stub --case says-ok --trials 1 2>&1)
  code=$?
  local ok=0
  [ "$code" -eq 2 ] || ok=1
  contains "jq is required" || ok=1
  expect missing_jq_exits_2 "$ok" "got exit $code"
}

t_malformed_json_exits_2; t_object_evals_exits_2; t_missing_jq_exits_2
t_regex_backslash_survives; t_missing_cli_exits_2; t_failed_assertion_fails_trial
t_case_passes; t_case_fails; t_majority_rule; t_baseline_runs_without; t_prompt_is_passed_verbatim
t_grader_garbage_fails_trial; t_unknown_agent_exits_2; t_unknown_case_exits_2; t_warns_global_skill_dirs
echo "$passed passed, $failed failed"
[ "$failed" -eq 0 ]
