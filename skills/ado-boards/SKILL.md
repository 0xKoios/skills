---
name: ado-boards
description: >-
  Azure Boards / ADO cards (tickets, work items, stories, tasks). Use when the
  user mentions their board, sprint, plate, or an item like #512 — even without
  saying Azure DevOps. Branches: set up the ado skill; show my cards; create or
  break into tasks; move or close; log time; comments; description or acceptance
  criteria; plan my sprint / what first. Board operations only (not app code,
  SQL, or pipelines).
license: MIT
---

# Azure DevOps Boards: my cards

Help one person manage their own **cards** on Azure Boards via MCP or `az`. Team conventions live in **config**; the same skill fits different teams.

## 1. Before anything else

1. **Read config** — `~/.config/ado-boards/config.md` (Windows: `%USERPROFILE%\.config\ado-boards\config.md`). Missing → run core setup (`workflows/setup.md`) first; guessing org/project writes to the wrong place. Values marked `not set yet` are collected the first time a workflow needs them.
2. **Pick backend** for this turn only:
   - **MCP** when Azure DevOps MCP tools are available (e.g. `wit_work_item`): load `mcp-tools.md` (plus one `az/` gap file only when that map documents an MCP gap).
   - **az** otherwise: load `az/README.md` plus the one section file for this workflow. Also `az/windows.md` only when an HTML description/AC write comes back mangled, or PowerShell quoting fails. Confirm login (`az account show` or `AZURE_DEVOPS_EXT_PAT`); if neither, the user runs `az login` themselves.
   - **Neither** → point at setup.
3. **Open the matching workflow** (table below) and follow it. Workflows say what; the backend file says how. Rules in §2 bind both backends.

Done when config is in hand, one backend is chosen, and the workflow file is open.

User signs in themselves (Entra / `az login`). Credentials stay out of chat.

## 2. Rules

**Reads need no permission. Every write needs a preview and an explicit yes** — even when the tool itself does not ask. The board is shared; MCP writes often skip a prompt, so **preview** is the gate.

| Rule | Criterion |
|---|---|
| **Preview size** | One change on the user's own card → one line (`#512: State Active -> Closed. OK?`). Several changes, or someone else's card → table (ID, field, old, new). More than 10 → state the count and confirm again. |
| **Read-back** | After every write: report ID, what changed, URL `https://dev.azure.com/<org>/<project>/_workitems/edit/<id>`. |
| **Parents** | When config says `Parent required: yes`, create only with a parent (orphans drop out of backlog views). |
| **Bugs** | When config says bugs live elsewhere: offer a Task under the existing bug (a second Bug splits history). |
| **External cards** | Title prefix in config (e.g. `EXT`): warn that comments may sync to the reporter before comment or field change; skip Impact on close. |
| **Units** | Time fields are plain numbers; unit is in config. Convert when the user speaks another unit, show both, always name the unit (Boards UI says "h" either way). |
| **Cards stay** | Close or move; leave the card on the board. Remove a comment only after showing it in full and getting yes — neither is undoable. |
| **Own comments** | Edit or remove only the user's own (ADO rejects the rest). |
| **Real values** | Ask for estimates, assignees, dates, impact — or leave blank. Invented numbers look real on the board. |
| **Safe quotes** | Quote values safely; titles may contain quotes. |
| **Write footer** | After a write: what you did, what you skipped, one next step. Plain reads: answer only. |

## 3. Workflows

| When | Open |
|---|---|
| Set up the ado skill; config missing; something changed | `workflows/setup.md` |
| What's on my plate; show my cards; move; log time; close | `workflows/my-cards.md` |
| Create a card; break a story into tasks | `workflows/create-card.md` |
| Add, list, edit, or remove a comment | `workflows/comments.md` |
| Description or acceptance criteria | `workflows/write-description.md` |
| Plan my sprint; what should I work on first | `workflows/plan-my-sprint.md` |

## 4. Agile reference (verify against config)

Hierarchy: Epic > Feature > User Story > Task. Bugs sit beside or under stories per team setting.

| Type | States |
|---|---|
| Feature / User Story | New, Active, Resolved, Closed, Removed |
| Bug | New, Active, Resolved, Closed |
| Task | New, Active, Closed, Removed |

Parents: Task under User Story (or Bug), User Story under Feature. Custom states and required fields live in config once collected.
