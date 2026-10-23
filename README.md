# skills

Agent skills I use for real work — starting with Azure Boards, growing as I need them.

Small, editable, installable one at a time. Works with Cursor, Claude Code, Copilot, Codex, Gemini CLI, and anything else that speaks [Agent Skills](https://agentskills.io/specification).

## Install

Needs [Node.js](https://nodejs.org/) 22.20+. Global install so every project sees the skill:

```bash
npx skills add 0xKoios/skills --skill ado-boards -g
```

Pick agents with `-a` (e.g. `-a cursor -a claude-code`), or `-a '*'` / `--all`. List what’s in the repo: `npx skills add 0xKoios/skills -l`. Update with `npx skills update`. On Windows without symlink support, add `--copy`.

## Skills

| Skill | What it does |
|---|---|
| [`ado-boards`](skills/ado-boards/) | Your own Azure DevOps Boards cards via MCP or `az`: view, create with parent, move, log time, comments, descriptions/AC, plan my sprint |

Reading never asks permission. Every write shows a preview and waits for your "yes".

## Edit / contribute

Installs are managed copies — don’t edit them. To change a skill, clone and link:

```bash
git clone https://github.com/0xKoios/skills ~/code/skills
ln -s ~/code/skills/skills/ado-boards ~/.claude/skills/ado-boards
# Cursor: ~/.cursor/skills/ado-boards — Copilot: ~/.copilot/skills/ado-boards
```

Remove any prior `npx skills` install of the same name first so the agent does not load two.

## License

[MIT](LICENSE)
