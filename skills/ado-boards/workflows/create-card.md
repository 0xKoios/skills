# Workflow: Create a card

Goal: create Tasks or User Stories (a Feature only if the user insists) with the right parent, area, sprint and required fields. How: `../mcp-tools.md` (MCP) or `../az/create.md` (az).

If the config says bugs are created in another system, do not create a Bug: explain, and offer a Task under the existing bug instead.

## Steps
1. **Type:** from the request. Unclear: ask "Task or User Story?".
2. **Parent** (required when the config says `Parent required: yes`; otherwise offer one):
   - The user gives an ID: read it and check the type fits (Task under User Story or Bug; User Story under Feature; Feature under Epic).
   - No ID: ask for keywords, search open cards of the right parent type, show the top 5 (ID, title, state, sprint), and let the user pick.
   - No suitable parent and one is required: stop and offer to search again rather than create an orphan.
3. **Copy from the parent:** area path and sprint (iteration path). If the parent has no sprint, ask: current sprint or backlog?
4. **Fields:**
   - Required custom fields: if the config has them `not set yet`, collect them first (setup, "On first need"); then ask for each.
   - Task: title, Original Estimate and Remaining Work in the config unit (ask; never invent), assigned to me.
   - User Story: run `write-description.md` first to get the description and acceptance criteria, then the title; assigned to me unless told otherwise.
5. **Preview:** one card: type, title, parent, area, sprint, estimate with unit, assignee, fields. Several cards (e.g. "break #520 into tasks"): a table, one row per card. Wait for "yes". More than 10: confirm the count.
6. **Create** each card with its parent link. With MCP, use `add_child`, which creates and links in one step. With az, create, capture the returned ID, then add the parent link.
7. **Read back** with relations and check the parent link. Report ID, title, parent, URL.

## Break a story into tasks
Propose tasks from the story's acceptance criteria (one task per meaningful step, plus testing), with estimates marked as suggestions. The user edits the list, then continue from step 5.

If a create fails halfway: stop, list what was created, and ask before retrying. Never delete to clean up; the partial cards are easier to fix than to recreate.
