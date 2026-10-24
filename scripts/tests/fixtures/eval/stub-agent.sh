#!/usr/bin/env bash
# Stub agent for eval-skill tests. Usage: stub-agent.sh <workspace> <prompt-file>
ws="$1"; prompt="$2"
if grep -q 'GRADE-THESE-ASSERTIONS' "$prompt"; then
  if [ "${STUB_GRADER_GARBAGE:-}" = 1 ]; then echo "not json"; exit 0; fi
  if grep -q 'DEMO-OK' "$prompt"; then p=true; else p=false; fi
  echo "{\"results\":[{\"assertion\":\"Says DEMO-OK\",\"passed\":$p,\"evidence\":\"stub\"}]}"
  exit 0
fi
if [ -f "$ws/.agents/skills/demo/SKILL.md" ]; then echo "DEMO-OK"; else echo "NO-SKILL"; fi
[ -n "${STUB_LOG:-}" ] && cat "$prompt" >> "$STUB_LOG"
exit 0
