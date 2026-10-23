# Workflow: Plan my sprint (priority order)

Goal: order the user's current-sprint cards and surface blockers. **Read-only** — advice in chat; nothing written to the board. No capacity maths. How: `../mcp-tools.md` (MCP) or `../az/plan-my-sprint.md` (az).

Priority tags `not set yet` → offer to collect (setup, on first need); skip → sort without them.

## Steps

1. Current sprint for the team in config → my cards in that sprint that are not Closed or Removed.
2. Per card: relations and fields — predecessor/successor (linked card state + assignee), tags, Priority, state, description/AC present?
3. **Sort**
   1. Blocks others (successor to an open card assigned to someone else)
   2. Already Active
   3. Priority tags from config
   4. Priority field (1 first, empty last)
   5. Else backlog order
   - **Blocked** (open predecessor) → bottom, with who to chase
4. Flag without moving: missing AC or estimate ("not ready"), external cards, unchanged 5+ working days.
5. Numbered list; each line carries its reason: `1. #498 Saved cards API: blocks #530 (Anan)`.
6. At most 3 questions, e.g. "#446 blocked by #150 (Team Accounts). Chase them, or start #513 first?"
7. User reorders ("put #520 first") → redo the list; keep reasons.

Done when the ordered list with reasons is shown (and any reorders applied).

Offer follow-ups; leave applying them to other workflows: write AC (`write-description.md`), break into tasks (`create-card.md`).
