# az backend

Use these files when Azure DevOps MCP tools are **not** available. When MCP is available, use `../mcp-tools.md` instead; come back here only for what MCP cannot do (e.g. removing a comment — see `comments.md`).

Assumes setup has run, so org and project are defaults (`az devops configure --defaults organization=https://dev.azure.com/<org> project="<project>"`). Values in `<angle brackets>` come from config or the user.

Commands are written on one line so they work in PowerShell and bash. Use `-o json` to parse; show results to the user as a short list or table.

**Load only this README plus the one section file for the current workflow.** Do not load other az sections or `../mcp-tools.md` in the same turn unless a documented MCP gap requires that one az file.

Not yet tested against a live org: if a command fails, show the error, do not guess a variant, and tell the user it needs fixing in the matching section file below.

## Section files

| Workflow | File |
|---|---|
| Setup | `setup.md` |
| My cards (view, move, log time, close) | `my-cards.md` |
| Create | `create.md` |
| Comments | `comments.md` |
| Plan my sprint | `plan-my-sprint.md` |
| Description and acceptance criteria | `write-description.md` |
| Windows / PowerShell / HTML `@file` | `windows.md` (load only when writing HTML or hitting PowerShell quoting issues) |

## Never

- `az boards work-item delete`: this skill never deletes cards.
- Printing or passing a PAT. Auth comes from `az login` or `AZURE_DEVOPS_EXT_PAT`.
