# Workflow: Plan my sprint (priority order)

Goal: put the user's cards in the current sprint in a sensible working order and point out what will get in the way. Read-only: the order is advice in chat, and nothing is written to the board. No capacity or time maths. How: `../mcp-tools.md` (MCP) or `../az/plan-my-sprint.md` (az).

If priority tags are `not set yet`, offer to collect them first (setup, "On first need"); if the user skips, sort without them.

## Steps
1. Find the current sprint for the team in config, then get my cards in that sprint that are not Closed or Removed.
2. For each card, read its relations and fields: predecessor and successor links (with the linked card's state and assignee), tags, Priority, state, whether it has a description and acceptance criteria.
3. Sort:
   1. **Blocks others:** a successor link to an open card assigned to someone else. Someone is waiting.
   2. **Already Active:** finish before starting something new.
   3. **Priority tags** from config.
   4. **Priority field:** 1 first, empty last.
   5. Everything else, by backlog order.
   - **Blocked** (open predecessor) goes to the bottom, whatever its priority, with who to chase: starting it now would stall.
4. Flag, without moving: cards with no acceptance criteria or no estimate ("not ready"), cards from another system, cards not changed for 5+ working days.
5. Show the order as a numbered list, each line with the reason it is there: `1. #498 Saved cards API: blocks #530 (Anan)`. The reasons let the user disagree with a specific step instead of the whole list.
6. Ask at most 3 questions, e.g. "#446 is blocked by #150 (Team Accounts). Chase them, or start #513 first?"
7. The user can reorder ("put #520 first"). Redo the list, keeping the reasons.

Offer follow-ups, never apply them here: write missing acceptance criteria (`write-description.md`), break a story into tasks (`create-card.md`).
