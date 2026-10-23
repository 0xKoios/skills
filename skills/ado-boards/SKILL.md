---
name: ado-boards
description: Manage your own Azure DevOps (ADO) Boards work items through Azure DevOps MCP tools or the az CLI. See what's on my plate, create a task or story under a parent, move or close a ticket, log hours or days, add, list, edit or remove my comments, write a description or acceptance criteria, and plan my sprint in priority order. Use it whenever the user talks about their ADO or Azure Boards cards, tickets, work items, stories, tasks, sprint or board, or refers to an item by number like #512, even if they do not say "Azure DevOps". Also use it to set up the ado skill. Not for writing the code, SQL or pipelines themselves.
license: MIT
---

# Azure DevOps Boards: my work items

You help one person manage their own work items ("cards") in Azure Boards, through Azure DevOps MCP tools or the `az` CLI. Their team's conventions live in a config file, so the same skill fits different teams.

## 1. Before anything else

1. **Read the config:** `~/.config/ado-boards/config.md` (Windows: `%USERPROFILE%\.config\ado-boards\config.md`). If it is missing, offer the short core setup (`workflows/setup.md`) before anything else: without it you would be guessing the org, project and team rules, and a wrong guess writes to the wrong place. A value marked `not set yet` is collected the first time a workflow needs it (setup explains how).
2. **Pick the backend:**
   - **MCP:** if Azure DevOps MCP tools are available (e.g. `wit_work_item`), use them. Tool map: `mcp-tools.md`. Read only that map (plus one az gap file if a documented MCP gap requires it). Do not load the az tree “just in case”.
   - **az:** otherwise use the `az` CLI. Commands live under `az/` — read `az/README.md` plus only the matching section file for this workflow. Do not load other az sections or `mcp-tools.md` in the same turn unless a documented MCP gap requires that one az file, or (only when an HTML description/AC write comes back mangled or PowerShell quoting fails) also `az/windows.md`. Check `az account show` (or `AZURE_DEVOPS_EXT_PAT` is set); if neither, ask the user to log in themselves.
   - Neither: point to setup. Never ask for, print or store a PAT or token: chat history and logs are not a safe place for credentials.

Workflows say what to do; look up how in the backend's file. The rules below apply to both.

## 2. Rules

**Reading never needs permission. Every write does,** even when the tool itself does not ask. The board is shared with the team, and MCP write tools often run without a prompt, so your preview is the only chance to catch a mistake before others see it.

- **Preview size:** one change to one of the user's own cards gets a one-line preview, e.g. `#512: State Active -> Closed. OK?`. Several changes, or a card assigned to someone else, get a table (ID, field, old, new). More than 10 changes: state the count and ask again, because a large batch is where a wrong filter does real damage.
- **Read back after every write** and report ID, what changed, and the URL `https://dev.azure.com/<org>/<project>/_workitems/edit/<id>`. Writes can partly fail or be changed by rules on the server; the read-back shows what is really there.
- **Parents:** if the config says `Parent required: yes`, never create a card without one. Teams that require parents lose orphan cards from their backlog views.
- **Bugs:** if the config says bugs are created in another system, do not create them here; a second copy splits the history and the reporter never sees it. Offer a Task under the existing bug instead.
- **Cards from another system** (title prefix in config, e.g. ExternalTracker `EXT`): before commenting or changing a field, warn that comments may sync back and be visible to the reporter. Do not ask for an Impact note on them.
- **Units:** time fields (Original Estimate, Remaining Work, Completed Work) are plain numbers; the team's unit is in the config. Convert when the user speaks in another unit and show both, and always say the unit. Azure Boards labels these fields "h" whatever the team uses, so an unlabeled number is easily misread by a factor of 8.
- **Never delete a card,** and remove a comment only after showing it in full and getting an explicit "yes". Neither can be undone.
- **Comments:** edit or remove only the user's own. Azure DevOps rejects the rest anyway, and trying wastes a step.
- **Do not invent values** (estimates, assignees, dates, impact). Made-up numbers look real on the board and feed the team's planning. Ask, or leave blank.
- Quote values safely; titles can contain quotes. With az, read `az/windows.md` only when an HTML description or acceptance-criteria write comes back mangled, or when PowerShell quoting fails.
- **After a write,** end with what you did, what you did not do, and one suggested next step. For plain reads, just answer.

## 3. Workflows

Pick the one that matches the request, read its file, and follow it.

| Request | File |
|---|---|
| "set up the ado skill", config missing, or something changed | `workflows/setup.md` |
| "what's on my plate", "show my cards", move, log time, close | `workflows/my-cards.md` |
| create a card, or break a story into tasks | `workflows/create-card.md` |
| add, list, edit or remove a comment | `workflows/comments.md` |
| write or improve a description or acceptance criteria | `workflows/write-description.md` |
| "plan my sprint", "what should I work on first" | `workflows/plan-my-sprint.md` |

## 4. Agile reference (verify against config)

Hierarchy: Epic > Feature > User Story > Task. Bugs sit beside or under stories depending on a team setting.

| Type | States |
|---|---|
| Feature / User Story | New, Active, Resolved, Closed, Removed |
| Bug | New, Active, Resolved, Closed |
| Task | New, Active, Closed, Removed |

Parents: Task under User Story (or Bug), User Story under Feature. Custom states and required fields are listed in the config once collected.
