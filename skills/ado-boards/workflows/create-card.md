# Workflow: Create a card

Goal: create Tasks or User Stories (Feature only if the user insists) with parent, area, sprint, and required fields. How: `../mcp-tools.md` (MCP) or `../az/create.md` (az).

When config says bugs live elsewhere: offer a Task under the existing bug (skip creating a Bug).

## Steps

1. **Type** — from the request. Unclear → "Task or User Story?"
2. **Parent** (required when `Parent required: yes`; otherwise offer one)
   - User gives an ID → read it; type must fit (Task under User Story or Bug; User Story under Feature; Feature under Epic).
   - No ID → keywords, search open cards of the parent type, show top 5 (ID, title, state, sprint), user picks.
   - Required parent missing → stop; offer another search (no orphans).
3. **Copy from parent** — area path and sprint. Parent has no sprint → ask: current sprint or backlog?
4. **Fields**
   - Required custom fields `not set yet` → collect first (setup, on first need), then ask for each.
   - Task: title, Original Estimate and Remaining Work in config unit (ask; leave blank rather than invent), assigned to me.
   - User Story: run `write-description.md` for description and AC, then title; assigned to me unless told otherwise.
5. **Preview** — one card: type, title, parent, area, sprint, estimate with unit, assignee, fields. Several cards (e.g. break into tasks): table, one row each. Wait for "yes". More than 10 → confirm the count.
6. **Create** with parent link. MCP: prefer `add_child` (create + link). az: create, capture ID, then parent relation.
7. **Read-back** with relations; confirm parent. Report ID, title, parent, URL.

Done when every created card is read back with the parent link.

## Break a story into tasks

Propose tasks from the story's acceptance criteria (one task per meaningful step, plus testing); mark estimates as suggestions. User edits the list, then continue from step 5.

If create fails halfway: stop, list what exists, ask before retry. Leave partial cards on the board (easier to fix than recreate).
