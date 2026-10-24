#!/usr/bin/env bash
# Stub agent for eval-skill tests. Usage: stub-agent.sh <workspace> <prompt-file>
# STUB_GRADER_GARBAGE=1: grader prints junk. STUB_AGENT_SILENT=1: agent prints SILENT instead of DEMO-OK.
ws="$1"; prompt="$2"
if grep -q 'GRADE-THESE-ASSERTIONS' "$prompt"; then
  if [ "${STUB_GRADER_GARBAGE:-}" = 1 ]; then echo "not json"; exit 0; fi
  # Judge only the agent-output section, not the assertion text.
  if awk '/^## Output/{o=1;next} /^## Assertions/{o=0} o' "$prompt" | grep -q 'DEMO-OK'; then p=true; else p=false; fi
  echo "{\"results\":[{\"assertion\":\"Says DEMO-OK\",\"passed\":$p,\"evidence\":\"stub\"}]}"
  exit 0
fi
if [ "${STUB_AGENT_SILENT:-}" = 1 ]; then echo "SILENT"
elif [ -f "$ws/.agents/skills/demo/SKILL.md" ]; then echo "DEMO-OK"; else echo "NO-SKILL"; fi
[ -n "${STUB_LOG:-}" ] && cat "$prompt" >> "$STUB_LOG"
exit 0
