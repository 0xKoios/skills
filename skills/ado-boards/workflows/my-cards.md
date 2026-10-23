# Workflow: My cards

Goal: day-to-day work on the user's own cards: see them, move them, log time, close them. How: `../mcp-tools.md` (MCP) or `../az/my-cards.md` (az).

## View my cards
Get cards assigned to me that are not Closed or Removed. Group by state, one line each: ID, type, title, sprint, Remaining Work with unit (tasks only). Mark cards in the current sprint, cards from another system (prefix in config), and cards missing a description or acceptance criteria, so the user sees at a glance what needs attention.

For "what did I touch today / this week", get cards changed by me in that range.

## Move a card
1. Read the card: type, current state, Remaining Work.
2. Check the target state is valid for the type (SKILL.md section 4, plus custom states in config). If the state is unknown and custom states are `not set yet`, collect them first (setup, "On first need").
3. Card from another system: give the warning first.
4. One-line preview, wait for "yes", update, read back.

## Log time on a task
User says e.g. "spent 0.5 day on #512", "spent 3h on #512" or "1 day left on #512".
1. Read current Completed Work and Remaining Work. An empty field counts as 0.
2. If the user's unit differs from the config's, convert with hours per day.
3. New values: Completed + spent; Remaining − spent, never below 0. If the user gives Remaining directly, use it.
4. Preview in the team unit, with the user's unit alongside when converted: `#512: Completed 1 -> 1.375 d, Remaining 2 -> 1.625 d (3h at 8h/day). OK?`
5. Update both fields, read back.

Only Tasks carry time in Agile. If the user logs time on a story, offer to log it on one of its tasks.

## Close a card
1. As "Move a card", to Closed (or Resolved for stories, if the team uses it).
2. Task with Remaining Work above 0: ask whether to set it to 0, so the sprint burndown is right.
3. If the config asks for Impact notes and the card is not from another system: ask "One line on impact? (skip is fine)". Example: "Orders load now runs in 15 min instead of 2 h". Write only what the user gave; work history later quotes these lines as facts.
4. Preview the state change and the Impact comment together, wait for "yes".
5. Update the state, then add the comment as `Impact: <text>`. Read back.
