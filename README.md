# skills

Skills I use for real work. This repo is a **collection**: each folder under `skills/` is one skill; install one at a time.

Works with Cursor, Claude Code, Copilot, Codex, Gemini CLI, and other [Agent Skills](https://agentskills.io/specification) hosts.

## Install

Needs [Node.js](https://nodejs.org/) 22.20+.

```bash
npx skills add 0xKoios/skills -s ado-boards -g
```

The supervisor stack (`supervisor`, `supervisor-reflect`, `supervisor-correct` and the 26 `principle-*` leaves) installs together; `-s` takes a space-separated list:

```bash
npx skills add 0xKoios/skills -g -s supervisor supervisor-reflect supervisor-correct \
  principle-attack-the-premise \
  principle-boundary-discipline \
  principle-build-the-lever \
  principle-encode-lessons-in-structure \
  principle-exhaust-the-design-space \
  principle-experience-first \
  principle-explain-the-number \
  principle-fix-root-causes \
  principle-foundational-thinking \
  principle-guard-the-context-window \
  principle-laziness-protocol \
  principle-look-before-you-write \
  principle-make-operations-idempotent \
  principle-migrate-callers-then-delete-legacy-apis \
  principle-minimize-reader-load \
  principle-model-the-domain \
  principle-never-block-on-the-human \
  principle-outcome-oriented-execution \
  principle-prove-it-works \
  principle-redesign-from-first-principles \
  principle-separate-before-serializing-shared-state \
  principle-sequence-verifiable-units \
  principle-subtract-before-you-add \
  principle-surgical-changes \
  principle-test-behavior-not-implementation \
  principle-type-system-discipline
```

Done when the agent lists `ado-boards`. `-g` makes it available in every project. Target agents with `-a` (e.g. `-a cursor`, or `-a '*'` / `--all`). Inventory: `npx skills add 0xKoios/skills -l`. Refresh: `npx skills update`. On Windows without symlinks, add `--copy`. Further flags: `npx skills --help`.

## Skills

| Skill | Reach for it when |
|---|---|
| [`ado-boards`](skills/ado-boards/) | Your Azure Boards cards — view, create under a parent, move, log time, comments, description/AC, plan my sprint. Reads free; every write previews first. |
| [`supervisor`](skills/supervisor/) | Explicit `/supervisor` front door: routes a task to a playbook, with principles, gates, escalation and evals. |
| [`supervisor-reflect`](skills/supervisor-reflect/), [`supervisor-correct`](skills/supervisor-correct/) | The improvement loop: reflect on what went wrong, then apply the corrections. |
| [`principle-*`](skills/) | 26 general engineering principle leaves the supervisor reads (24 adapted from pstack plus 2 of the user's); also invocable by hand. |

## Edit a skill

**Link** a clone into the agent's skills folder so edits land in this repo:

```bash
git clone https://github.com/0xKoios/skills ~/code/skills
ln -s ~/code/skills/skills/ado-boards ~/.claude/skills/ado-boards
```

Other agents use the same idea with their skills path (`~/.cursor/skills/ado-boards`, `~/.copilot/skills/ado-boards`). Done when the agent loads this clone as its only copy of that skill — clear any prior `npx skills` install of the same name, then link.

## License

[MIT](LICENSE)
