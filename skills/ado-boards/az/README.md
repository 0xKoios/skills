# az backend

Use when Azure DevOps MCP tools are unavailable. With MCP, prefer `../mcp-tools.md`; open one file here only for documented gaps (e.g. remove comment → `comments.md`).

Assumes setup ran: org and project are defaults (`az devops configure --defaults organization=https://dev.azure.com/<org> project="<project>"`). `<angle brackets>` come from config or the user.

One-line commands for PowerShell and bash. Parse with `-o json`; show the user a short list or table.

**Load this README plus the one section file for the current workflow.** Load another az file or `../mcp-tools.md` in the same turn only for a documented MCP gap. Load `windows.md` only when an HTML description/AC write comes back mangled, or PowerShell quoting fails.

Live-org status: not yet verified. On failure: show the error, leave the command as written, and say it needs a fix in that section file.

## Section files

| Workflow | File |
|---|---|
| Setup | `setup.md` |
| My cards (view, move, log time, close) | `my-cards.md` |
| Create | `create.md` |
| Comments | `comments.md` |
| Plan my sprint | `plan-my-sprint.md` |
| Description and acceptance criteria | `write-description.md` |
| Windows / PowerShell / HTML `@file` | `windows.md` |

## Guardrails

- Cards stay on the board — this skill never runs `az boards work-item delete`.
- Auth via `az login` or `AZURE_DEVOPS_EXT_PAT`; PATs stay out of chat.
