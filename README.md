# skills

Skills I use for real work. This repo is a **collection**: each folder under `skills/` is one skill; install one at a time.

Works with Cursor, Claude Code, Copilot, Codex, Gemini CLI, and other [Agent Skills](https://agentskills.io/specification) hosts.

## Install

Needs [Node.js](https://nodejs.org/) 22.20+.

```bash
npx skills add 0xKoios/skills -s ado-boards -g
npx skills add 0xKoios/skills -s brag-docs -g
```

Done when the agent lists the skill you installed. `-g` makes it available in every project. Target agents with `-a` (e.g. `-a cursor`, or `-a '*'` / `--all`). Inventory: `npx skills add 0xKoios/skills -l`. Refresh: `npx skills update`. On Windows without symlinks, add `--copy`. Further flags: `npx skills --help`.

## Skills

| Skill | Reach for it when |
|---|---|
| [`ado-boards`](skills/ado-boards/) | Your Azure Boards cards — view, create under a parent, move, log time, comments, description/AC, plan my sprint. Reads free; every write previews first. |
| [`brag-docs`](skills/brag-docs/) | Living brag document — `brag-setup`, `brag-capture`, `brag-backfill`. Markdown default; action → result → evidence; preview before write. |

## Edit a skill

**Link** a clone into the agent's skills folder so edits land in this repo:

```bash
git clone https://github.com/0xKoios/skills ~/code/skills
ln -s ~/code/skills/skills/ado-boards ~/.claude/skills/ado-boards
ln -s ~/code/skills/skills/brag-docs ~/.claude/skills/brag-docs
```

Other agents use the same idea with their skills path (`~/.cursor/skills/<name>`, `~/.copilot/skills/<name>`). Done when the agent loads this clone as its only copy of that skill — clear any prior `npx skills` install of the same name, then link.

## License

[MIT](LICENSE)
