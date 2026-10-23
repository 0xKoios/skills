# Workflow: Setup

Goal: create or refresh `~/.config/ado-boards/config.md` (Windows: `%USERPROFILE%\.config\ado-boards\config.md`) from `../config.template.md`. How: `../mcp-tools.md` (MCP) or `../az/setup.md` (az).

**Core** runs once so the user can see cards quickly. **On first need** fills the rest when a workflow hits `not set yet` — answers are better with a real task in view.

## Core (first run, or "set up the ado skill")

1. **Backend** — detect MCP (e.g. `wit_work_item`), then `az` (`az --version`, `azure-devops` extension, `az account show` or `AZURE_DEVOPS_EXT_PAT`). Report which work. Neither: explain MCP (Entra / remote server) and az (`az login --allow-no-subscriptions`), then stop. MCP-only is fine (comment remove then needs az or the web UI). az installed but not logged in → user runs `az login` themselves.
2. **Connection** — ask org URL, project, team (ask; leave blanks empty until answered). MCP: verify with `core_list_projects` / `core_list_project_teams`. az: `az devops configure --defaults`, then `az devops project show`. Read the process template; if not Agile, note that type and state names differ.
3. **Me** — email from `az account show --query user.name`, from assignee on my cards (MCP `wit_work_item` `my`), or ask. Confirm.
4. **Units** — "Hours or days? Hours per day?" Default: hours, 8.
5. **Team rules** — one short question each [defaults]:
   - Parent required on every card? [yes]
   - Bugs created here, or elsewhere (e.g. ExternalTracker)? [here]
   - Cards from another system with a title prefix (e.g. `EXT`)? [none] If yes: comments sync back? [unknown]
   - Ask for a one-line Impact note on close? [yes]
6. **Write** — show the filled config (`not set yet` for later parts). After "yes", write only under `~/.config/ado-boards/` (or the Windows equivalent) — the skill/repo folder stays template-only.

Done when the config file exists and the user has a next step. Suggest: "show my cards".

## On first need

When a workflow needs a `not set yet` value: run the step, preview the config addition, write after "yes", continue. User says "skip" → keep `not set yet` and use defaults for this run.

| Value | Needed by | Step |
|---|---|---|
| Custom states and required fields | create, or move to a non-standard state | Read User Story and Task types. Keep only differences from Agile: extra states, required or `Custom.*` fields. |
| Priority tags | plan my sprint | Tags on my cards changed in the last 90 days, with counts. Ask which mean "do first". |
| Acceptance criteria team style | writing AC | Read ~10 recently closed User Stories in the team's area; summarize style in 2–3 lines (bullet count, Given/When/Then or not, recurring patterns); confirm with the user. |

Rerun core when the user changes team or project.
