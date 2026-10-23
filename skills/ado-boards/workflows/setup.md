# Workflow: Setup

Goal: create or refresh `~/.config/ado-boards/config.md` (Windows: `%USERPROFILE%\.config\ado-boards\config.md`) from `../config.template.md`. How: `../mcp-tools.md` (MCP) or `../az/setup.md` (az).

Setup has two parts. The **core** runs once and takes a couple of minutes, so the user can see their cards right away. The **on-first-need** parts run later, inside the workflow that needs them, because asking everything up front makes the first run long and the answers are better with a real task in front of the user.

## Core (first run, or "set up the ado skill")
1. **Backend:** check whether Azure DevOps MCP tools are available (e.g. `wit_work_item`). Then check `az`: `az --version`, the `azure-devops` extension, and login (`az account show` or `AZURE_DEVOPS_EXT_PAT`). Report which work. Neither: explain both options (README "Requirements") and stop. MCP only is fine (removing comments then needs the web UI). If az is installed but not logged in, ask the user to run `az login --allow-no-subscriptions` themselves.
2. **Connection:** ask for the org URL, project and team; do not guess. With MCP, check them with `core_list_projects` and `core_list_project_teams`. With az, save org and project as defaults with `az devops configure --defaults` and check with `az devops project show`. Read the process template; if it is not Agile, say that type and state names differ.
3. **Me:** take the email from `az account show --query user.name`, or from the assignee of the user's cards (MCP `wit_work_item` `my`), or ask. Confirm.
4. **Units:** "Does your team estimate in hours or days? How many hours is a day?" Default: hours, 8.
5. **Team rules,** one short question each, defaults in brackets:
   - Must every card have a parent? [yes]
   - Are bugs created here, or in another system such as ExternalTracker? [here]
   - Do cards arrive from another system with a title prefix (e.g. `EXT`)? [none] If yes: do comments sync back? [unknown, test it once]
   - Ask for a one-line Impact note when you close a card? [yes] (used later for work history)
6. **Write:** show the filled config, with later parts marked `not set yet`. After "yes", create the folder and write the file. Never write it inside the skill or repo folder: the repo may be public.

Then suggest: "show my cards".

## On first need
When a workflow needs a value marked `not set yet`, run the matching step, show the addition to the config, write it after "yes", then continue the workflow. If the user says "skip", carry on with defaults and leave it `not set yet`.

| Value | Needed by | Step |
|---|---|---|
| Custom states and required fields | creating a card, or moving to a state not in the Agile reference | Read the User Story and Task types. Keep only differences from standard Agile: extra states, and required or `Custom.*` fields. |
| Priority tags | plan my sprint | List the tags on the user's cards changed in the last 90 days, with counts. Ask which ones mean "do first". |
| Acceptance criteria checklist and team style | writing acceptance criteria | Ask whether the work is data engineering (use `../ac-data-engineering.md`) or general. Read the criteria of about 10 recently closed User Stories in the team's area and summarize the style in 2 or 3 lines; ask the user to confirm. |

Rerun the core when the user changes team or project.
