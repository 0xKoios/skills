# Azure DevOps MCP tools

Backend map when MCP tools are available (`wit_work_item`, `wit_work_item_write`, `work`, …). Names match Microsoft's Azure DevOps MCP Server — remote `https://mcp.dev.azure.com/<org>` or local `@azure-devops/mcp`. Most tools take an `action`.

`SKILL.md` rules still bind. MCP writes often skip a host prompt — **preview** and "yes" are the gate.

Live-org status: not yet verified. Missing or failing tool → say so; load the one matching file under `az/` if az is logged in (that gap file only).

## Setup

| Need | Tool | Action |
|---|---|---|
| Projects | `core_list_projects` | |
| Teams | `core_list_project_teams` | |
| States and fields of a type | `wit_work_item` | `get_type` |
| Tags on my cards | `wit_work_item` | `my`, then count `System.Tags` |
| Team AC style | no direct tool (WIQL is Insiders-only) | `az/setup.md` if available; else ask for 3 example story IDs → `wit_work_item` `get_batch` |
| Team default area and iteration | `work` | `get_team_settings` |

MCP-only: skip `az devops configure --defaults` (org is in the server URL). Still record org, project, team in config.

## My cards

| Need | Tool | Action |
|---|---|---|
| My open cards | `wit_work_item` | `my` (drop Closed and Removed) |
| Cards I changed in a date range | no direct tool (needs WIQL) | `az/my-cards.md` if available; else `wit_work_item` `my` and note the list may miss range coverage |
| One card with links | `wit_work_item` | `get` (relations) |
| Several cards | `wit_work_item` | `get_batch` |
| Move, log time, write fields | `wit_work_item_write` | `update` |
| Impact comment | `wit_work_item_comment_write` | `add` |

## Create

| Need | Tool | Action |
|---|---|---|
| Find a parent by keyword | `search_workitem` | |
| Create under a parent | `wit_work_item_write` | `add_child` (create + link) |
| Create, then link | `wit_work_item_write` `create`, then `wit_work_item_link_write` `link` | |

Prefer `add_child` so a failed second step cannot leave an orphan.

## Comments

| Need | Tool | Action |
|---|---|---|
| Add | `wit_work_item_comment_write` | `add` |
| List | `wit_work_item` | `list_comments` |
| Edit | `wit_work_item_comment_write` | `update` |
| Remove | **no MCP tool** | DELETE in `az/comments.md`; without az → card URL for the web UI |

## Plan my sprint

| Need | Tool | Action |
|---|---|---|
| Current sprint | `work` | `list_team_iterations` (timeframe current) |
| Cards in the sprint | `wit_work_item` | `list_for_iteration`, keep assigned to me |
| Links, tags, priority | `wit_work_item` | `get` per card; relations as in `az/plan-my-sprint.md` |

## Read-only servers

`X-MCP-Readonly: true` hides `*_write` tools. Reads still work. Writes → az if logged in; otherwise say the server is read-only.
