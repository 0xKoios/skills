# Workflow: My cards

Goal: day-to-day work on the user's own cards — view, move, log time, close. How: `../mcp-tools.md` (MCP) or `../az/my-cards.md` (az).

## View my cards

Load cards assigned to me that are not Closed or Removed. Group by state; one line each: ID, type, title, sprint, Remaining Work with unit (tasks only). Flag: current sprint, external prefix (config), missing description or AC.

"What did I touch today / this week" → cards I changed in that range.

Done when the list is shown; no preview (read-only).

## Move a card

1. Read the card: type, state, Remaining Work.
2. Confirm the target state for the type (`../SKILL.md` §4 + custom states in config). Unknown state and custom states `not set yet` → collect first (setup, on first need).
3. External card → warn first.
4. One-line **preview**, wait for "yes", update, **read-back**.

Done when read-back shows the new state.

## Log time on a task

Examples: "spent 0.5 day on #512", "spent 3h on #512", "1 day left on #512".

1. Read Completed Work and Remaining Work (empty = 0).
2. Convert if the user's unit differs from config (hours per day).
3. New totals: Completed + spent; Remaining − spent (floor 0). Direct Remaining from the user wins.
4. Preview in team unit; show the user's unit alongside when converted: `#512: Completed 1 -> 1.375 d, Remaining 2 -> 1.625 d (3h at 8h/day). OK?`
5. Update both fields, read-back.

Only Tasks carry time in Agile. Time on a story → offer to log on one of its tasks.

Done when read-back shows both totals.

## Close a card

1. Move to Closed (or Resolved for stories, if the team uses it) — same preview gate as Move.
2. Task with Remaining Work > 0 → ask whether to set Remaining to 0 (burndown).
3. If config asks for Impact and the card is not external: "One line on impact? (skip is fine)". Write only what the user gave.
4. Preview state change and Impact comment together; wait for "yes".
5. Update state; add comment as `Impact: <text>`; read-back.

Done when read-back shows Closed/Resolved and any Impact comment.
