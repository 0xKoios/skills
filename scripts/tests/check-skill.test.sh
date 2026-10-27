#!/usr/bin/env bash
# Tests for scripts/check-skill.sh, run against fixture skill dirs via SKILLS_DIR.
# Usage: bash scripts/tests/check-skill.test.sh   (exits 1 if any test fails)
set -u
here="$(cd "$(dirname "$0")" && pwd)"
check="$here/../check-skill.sh"
F="$here/fixtures/check"
passed=0
failed=0

# run_check <skills_dir or empty for default>: sets $out and $code
run_check() {
  if [ -n "$1" ]; then out=$(SKILLS_DIR="$1" bash "$check" 2>&1); else out=$(bash "$check" 2>&1); fi
  code=$?
}
# expect <test> <0 if ok> <detail>
expect() {
  if [ "$2" -eq 0 ]; then
    passed=$((passed + 1)); echo "PASS: $1"
  else
    failed=$((failed + 1)); echo "FAIL: $1 ($3)"; printf '%s\n' "$out" | sed 's/^/    /'
  fi
}
contains() { printf '%s\n' "$out" | grep -qF -- "$1"; }

t_good() {
  run_check "$F/good/skills"
  expect t_good "$code" "expected exit 0, got $code"
}

t_bad_flag() {
  run_check "$F/bad-flag/skills"
  local ok=0
  [ "$code" -eq 1 ] || ok=1
  contains "principle-demo/SKILL.md: needs disable-model-invocation: true" || ok=1
  expect t_bad_flag "$ok" "expected exit 1 and flag message, got $code"
}

t_bad_evals() {
  run_check "$F/bad-evals/skills"
  local ok=0 msg
  [ "$code" -eq 1 ] || ok=1
  for msg in \
    "evals.json: skill_name 'wrong' must be 'demo'" \
    "evals.json: duplicate id 'a'" \
    "evals.json: eval 'b' needs checks or assertions" \
    "evals.json: eval 'c' check type 'nope' unknown" \
    "evals.json: eval 'c' file evals/files/missing.txt not found"; do
    contains "$msg" || { ok=1; echo "  missing: $msg"; }
  done
  expect t_bad_evals "$ok" "expected exit 1 and all five messages, got $code"
}

t_repo() {
  run_check ""
  expect t_repo "$code" "expected exit 0, got $code"
}

t_bad_json() {
  run_check "$F/bad-json/skills"
  local ok=0
  [ "$code" -eq 1 ] || ok=1
  contains "evals.json: invalid JSON" || ok=1
  expect t_bad_json "$ok" "expected exit 1 and invalid JSON message, got $code"
}

t_bad_shape() {
  run_check "$F/bad-shape/skills"
  local ok=0
  [ "$code" -eq 1 ] || ok=1
  contains "evals.json: .evals must be a non-empty array" || ok=1
  expect t_bad_shape "$ok" "expected exit 1 and array message, got $code"
}

t_good; t_bad_flag; t_bad_evals; t_bad_json; t_bad_shape; t_repo
echo "$passed passed, $failed failed"
[ "$failed" -eq 0 ]
