# Design: personal skills collection (`0xKoios/skills`)

## Intent

Stop treating this project as a single-skill product (`ado-boards-skill`). Instead, publish a **personal skills collection** at `0xKoios/skills`, in the spirit of Matt Pocock’s `mattpocock/skills` and poteto’s pstack: skills you actually use, installable one at a time, useful to you and to other people.

Day one ships only **`ado-boards`**. The old GitHub repo is deleted after the move.

## Why now

- Install currently reads `npx skills add 0xKoios/ado-boards-skill --skill ado-boards -g` — repo name and skill name say the same thing twice.
- Phase 3 already planned a second skill (`ado-dev-workflow`); a collection repo is the right shape before that lands.
- Primary install path is already `npx skills`; a collection repo matches that CLI’s model (repo = package, folder = skill).

## Goals

- New public GitHub repo: **`0xKoios/skills`**.
- Flat layout: `skills/<name>/SKILL.md` (no category folders in this phase).
- Move **`ado-boards`** into that repo as the first skill (full skill tree: workflows, az recipes, mcp-tools, config template, AC checklist, etc.).
- README: short personal voice + install + skill index (Matt/pstack tone, not a product brochure).
- Primary install:

  ```bash
  npx skills add 0xKoios/skills --skill ado-boards -g
  ```

- Linked clone remains the edit path for contributors / future-you.
- After the new repo works (`npx skills add … -l` lists `ado-boards`), **delete** `0xKoios/ado-boards-skill` on GitHub.
- Keep ado-boards user config at `~/.config/ado-boards/config.md` (unchanged path and meaning).

## Non-goals (this phase)

- Second skill (`ado-dev-workflow` or anything else) — not required on day one.
- Category folders (`skills/engineering/…`).
- Copilot plugin / `plugin.json` / `.github/plugin/marketplace.json` — dropped.
- `gh skill` as a documented install path — optional to omit; not required.
- Bringing `archive/team-workflows/` into the new repo.
- Renaming the existing GitHub repo in place (explicitly: **new** repo instead).

## Anti-goals

- Leaving both repos publishing `ado-boards` long-term (two homes, divergent copies).
- Deleting the old GitHub repo before the new install path is verified.
- Putting filled-in org config in the new repo (same rule as today: template only; home-folder config).

## Constraints

- New repo must be discoverable by `npx skills` (skill folders under `skills/*/SKILL.md`).
- Structure check / CI should still validate every skill under `skills/` (adapt existing `scripts/check-skill.sh` ideas; drop plugin-manifest checks that only served Copilot marketplace).
- Windows/macOS/Linux still matter for ado-boards (az + MCP + config paths).
- Deleting the old repo breaks anyone still using `0xKoios/ado-boards-skill` install URLs — accepted; no long redirect period required beyond a correct cutover.

## Decisions (agreed)

| Topic | Decision |
|---|---|
| Collection name | `0xKoios/skills` |
| Audience | Personal toolkit **and** public install |
| Day-one contents | `ado-boards` only |
| Repo strategy | New repo; do not rename this one |
| Migration | Move `ado-boards` now |
| Old GitHub repo | Delete after successful move |
| README tone | Matt / pstack personal style |
| Layout | Flat `skills/` this phase |
| Copilot plugin | Drop |

## Builder calls (unless overridden)

- Local path for the new clone: sibling of this project, e.g. `~/Personal/projects/skills` (or `~/code/skills` if that matches the machine). Prefer the same parent directory as `ado-boards-skill`.
- Carry over into the new repo: `skills/ado-boards/**`, `EXAMPLES.md` / `TESTS.md` if they document ado-boards (place at repo root or under the skill — prefer **under `skills/ado-boards/`** or repo-root docs that clearly belong to the collection; builder picks the least confusing option and notes it).
- Collection-level `LICENSE` (MIT, same as today).
- Collection README lists skills in a small table; ado-boards keeps its own deeper docs as needed.
- Do **not** carry Copilot marketplace files, `plugin.json`, or plugin-oriented release steps.
- Old **local** `ado-boards-skill` directory: leave on disk until GitHub delete is done; do not auto-delete the local folder unless asked.
- Commit history: fresh repo is fine (copy files); full git history rewrite is out of scope.

## Cutover sequence (outline)

1. Create empty `0xKoios/skills` on GitHub; clone locally.
2. Copy `ado-boards` skill + adapted README, LICENSE, structure check, CI.
3. Push; verify `npx skills add 0xKoios/skills -l` shows `ado-boards`.
4. Smoke: global install `-g`, trigger “show my cards” / setup in one agent.
5. Delete GitHub repo `0xKoios/ado-boards-skill`.
6. Update any personal notes/bookmarks; local old clone is disposable.

## Out of scope for the builder without a new request

- Authoring Phase 2/3 skill content.
- Migrating stars/traffic or setting up GitHub redirects (delete is hard cut).
- Publishing to skills.sh / other registries beyond GitHub + `npx skills`.
