# Hand-run tests

Run these in the agent you installed the skill in (Copilot, Claude Code, Cursor, ...). Repeat section 1 and 2 in each agent you use: triggering differs between tools. Use a test story and its tasks, not real work. Tick each box when the result matches. When one fails, fix the `description` in `SKILL.md` (triggering) or the workflow file (behavior), then run that test again.

## 1. Should trigger ado-boards

- [ ] "show my cards" → lists my open cards grouped by state
- [ ] "set up the ado skill" → starts setup
- [ ] "plan my sprint" → priority-ordered list with reasons
- [ ] "spent 0.5 day on #<task>" → time-logging preview
- [ ] "edit my comment on #<task>" → lists comments, picks mine
- [ ] "help me write acceptance criteria for #<story>" → asks about gaps
- [ ] "create a task under #<story>: add row-count check" → create preview
- [ ] "what should I work on first?" → priority-ordered list
- [ ] "what's on my plate this week?" → lists my open cards
- [ ] "update my ticket 512 to done" → move preview (says "ticket", not "card")

## 2. Should NOT trigger ado-boards

- [ ] "fix the failing dbt model"
- [ ] "write a SQL query that counts orders per day"
- [ ] "explain this pipeline"
- [ ] "create a git branch"
- [ ] "summarize this notebook"

## 3. Behavior: one check per rule

| # | Prompt | Expected | Pass |
|---|---|---|---|
| 1 | Any request with the config file missing | Offers the core setup only (connection, me, units, team rules); no questions about tags or AC style yet; does not guess org or project | [ ] |
| 2 | "show my cards" | No confirmation asked (read-only) | [ ] |
| 3 | "move #<task> to Active" | One-line preview, waits for yes, reads back | [ ] |
| 4 | "spent 3h on #<task>" (team unit: days) | Converts to days with hours per day, shows both units before writing | [ ] |
| 4b | Log time on a task whose Completed Work is empty | Treats it as 0, no error | [ ] |
| 5 | "close #<task>" with Remaining Work above 0 | Asks to set Remaining to 0, asks for optional Impact line | [ ] |
| 6 | "close #<task>", answer "skip" to impact | No Impact comment added | [ ] |
| 7 | "create a task: test something" (no parent, config: parent required) | Asks for parent or searches; does not create an orphan | [ ] |
| 8 | "create a bug for the failed load" (config: bugs created in another system) | Does not create a Bug, explains why, offers a Task under the existing bug | [ ] |
| 8b | Same, with config: bugs created here | Creates the Bug normally (preview first) | [ ] |
| 9 | "break #<story> into tasks" | Table preview, estimates marked as suggestions, area and sprint from the story | [ ] |
| 10 | "edit <teammate>'s comment on #<card>" | Refuses: own comments only | [ ] |
| 11 | "remove my comment on #<task>" | Shows the full comment, needs explicit yes | [ ] |
| 12 | Comment on a card from another system (prefix in config) | Warning about sync to the other system before posting | [ ] |
| 13 | Close a card from another system | No Impact question | [ ] |
| 14 | "plan my sprint" with a blocked card | Blocked card at the bottom with who to chase; nothing written to the board | [ ] |
| 14b | First "plan my sprint" (priority tags not set yet) | Offers to collect priority tags first; "skip" still gives an order | [ ] |
| 15 | "write AC for #<story>" | Asks clarifying questions for description and pass/fail AC; 3 to 7 bullets in team style | [ ] |
| 15b | First "write AC" (team style not set yet) | Offers to learn the team style from recent closed stories first | [ ] |
| 16 | Any write | Ends with done / not done / next step | [ ] |
| 17 | "show my cards" (a plain read) | Just the answer, no done / not done footer | [ ] |

## 4. Backends

Run sections 1 to 3 with the backend you have. If you have both, also check:

- [ ] With MCP tools available, the agent uses them (not `az`) for reading and writing, and does not open the full `az/` tree (only a documented gap file such as `az/comments.md` if needed)
- [ ] MCP write: still shows the preview and waits for "yes" even though the tool does not ask
- [ ] "remove my comment" with MCP only: offers `az` via `az/comments.md` if logged in, otherwise gives the card URL for the web UI
- [ ] MCP server set to read-only: writes fall back to `az` or are explained, never silently skipped
- [ ] Neither MCP nor `az`: setup explains both options and stops
- [ ] Az-only "show my cards": agent loads `az/my-cards.md` (and maybe `az/README.md`), not `az/comments.md` or `az/windows.md`

### December readiness (when the company enables MCP)

- [ ] Add the Azure DevOps MCP server per the README (remote URL or local; company Entra rules apply)
- [ ] Re-run this section with MCP available
- [ ] No special reinstall: a normal `gh skill update` / plugin update is enough if the skill files changed earlier

## 5. Things only a live org can tell us

- [ ] az: Comments API (list, edit, remove) works with `7.1-preview.4`
- [ ] MCP: `wit_work_item` `my`, `list_for_iteration` and `wit_work_item_write` `add_child` behave as `mcp-tools.md` says
- [ ] `az boards iteration team list --timeframe current` returns the current sprint
- [ ] Acceptance criteria with HTML reads back intact on Windows (or the `@file` fallback works)
- [ ] A comment on an EXT card does / does not appear in ExternalTracker (record the answer in config)
- [ ] `gh skill publish --dry-run` passes
