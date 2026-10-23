# ado-boards config

Template only. Setup (`workflows/setup.md`) copies this to `~/.config/ado-boards/config.md` (Windows: `%USERPROFILE%\.config\ado-boards\config.md`) and fills it in. Shared across agents. Leave this file blank of secrets — it ships in a public repo.

The agent has no memory between chats; this file is how it remembers the project. Values marked `not set yet` are collected the first time a workflow needs them.

## Connection (core setup)
- Organization URL: https://dev.azure.com/<org>
- Project: <project>
- Team: <team>
- Me (email used in Azure DevOps): <me@company.com>
- Process template: Agile

## Units (core setup)
- Work unit for Original Estimate / Remaining Work / Completed Work: hours
- Hours per day (for converting between hours and days): 8

## Team rules (core setup)
- Parent required: yes
- Bugs are created: here
  (or: in another system, e.g. "in ExternalTracker" — then this skill offers Tasks under existing bugs)
- Cards from another system: none
  (or: name and title prefix, e.g. "ExternalTracker, prefix EXT")
- Do comments on those cards sync back to the other system? unknown
- Ask for a one-line Impact note when closing a card: yes

## Custom states and required fields (collected on first create or move)
- not set yet

| Type | Extra state | Comes after | Counts as done? |
|---|---|---|---|

| Type | Field reference name | Display name | Allowed values / notes |
|---|---|---|---|

## Priority tags (collected on first "plan my sprint")
- not set yet

## Acceptance criteria (collected on first "write acceptance criteria")
- Team style: not set yet (e.g. 3 to 5 bullets, no Given/When/Then)

## Default area path (used only when a parent has none)
- <project>\<area>
