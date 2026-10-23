# Azure DevOps MCP tools

Use this file instead of the `az/` recipes when Azure DevOps MCP tools are available (tools named `wit_work_item`, `wit_work_item_write`, `work`, ...). Names below match Microsoft's Azure DevOps MCP Server, remote (`https://mcp.dev.azure.com/<org>`) and local (`@azure-devops/mcp`). Most tools take an `action` parameter.

All rules in `SKILL.md` stay the same. MCP write tools may run without the agent asking first, so the skill's own preview and "yes" are the only safety check: never skip them.

Not yet tested against a live org. If a tool or action is missing or fails, say so, and use the matching file under `az/` if `az` is logged in; otherwise tell the user what could not be done. Load only that one az gap file, not the whole az tree.

## Setup

| Need | Tool | Action |
|---|---|---|
| Projects | `core_list_projects` | |
| Teams | `core_list_project_teams` | |
| States and fields of a type | `wit_work_item` | `get_type` |
| Tags on my cards | `wit_work_item` | `my`, then count `System.Tags` |
| Team's acceptance-criteria style | no direct tool (WIQL is Insiders-only) | use `az/setup.md` if available; otherwise ask the user for 3 example story IDs and read them with `wit_work_item` `get_batch` |
| Team default area and iteration | `work` | `get_team_settings` |

With MCP only, `az devops configure --defaults` is not needed; the org is in the MCP server URL. Still record org, project and team in the config.

## My cards

| Need | Tool | Action |
|---|---|---|
| My open cards | `wit_work_item` | `my` (filter out Closed and Removed) |
| Cards I changed in a date range | no direct tool (needs WIQL) | use `az/my-cards.md` if available; otherwise use `wit_work_item` `my` and say the list may not cover everything changed in that range |
| One card with links | `wit_work_item` | `get` (ask for relations) |
| Several cards | `wit_work_item` | `get_batch` |
| Move, log time, write fields | `wit_work_item_write` | `update` |
| Impact comment | `wit_work_item_comment_write` | `add` |

## Create

| Need | Tool | Action |
|---|---|---|
| Find a parent by keyword | `search_workitem` | |
| Create a card under a parent | `wit_work_item_write` | `add_child` (creates and links in one step) |
| Create, then link | `wit_work_item_write` `create`, then `wit_work_item_link_write` `link` | |

Prefer `add_child`: it cannot leave an orphan if the second step fails.

## Comments

| Need | Tool | Action |
|---|---|---|
| Add | `wit_work_item_comment_write` | `add` |
| List | `wit_work_item` | `list_comments` |
| Edit | `wit_work_item_comment_write` | `update` |
| Remove | **no MCP tool** | use the DELETE command in `az/comments.md`; without `az`, tell the user to remove it in the web UI and give the card URL |

## Plan my sprint

| Need | Tool | Action |
|---|---|---|
| Current sprint | `work` | `list_team_iterations` (pick the one whose time frame is current) |
| Cards in the sprint | `wit_work_item` | `list_for_iteration`, then keep cards assigned to me |
| Links, tags, priority | `wit_work_item` | `get` per card, relations as in `az/plan-my-sprint.md` |

## Read-only servers

A server can be configured read-only (`X-MCP-Readonly: true`), so `*_write` tools are missing. Reading still works. For writes, use `az` if logged in; otherwise explain that the MCP server is read-only.
