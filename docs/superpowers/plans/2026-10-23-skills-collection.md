# Skills collection migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create `0xKoios/skills` with `ado-boards` as the first skill, verify `npx skills` install, then delete `0xKoios/ado-boards-skill` on GitHub.

**Architecture:** Fresh sibling repo; copy `skills/ado-boards` and adapt collection-level README/CI/check script; no Copilot plugin files; hard cutover by deleting the old GitHub repo after verify.

**Tech Stack:** Agent Skills (`SKILL.md`), bash structure check, GitHub Actions, `npx skills`, `gh`.

**Spec:** `docs/superpowers/specs/2026-10-23-skills-collection-design.md`

## Global Constraints

- Collection repo name: `0xKoios/skills`
- Flat `skills/<name>/` only; day one: `ado-boards` only
- No `plugin.json`, no `.github/plugin/marketplace.json`
- Primary install: `npx skills add 0xKoios/skills --skill ado-boards -g`
- Config path stays `~/.config/ado-boards/config.md`
- Do not delete old GitHub repo until `npx skills add 0xKoios/skills -l` lists `ado-boards`
- Do not auto-delete the local `ado-boards-skill` folder

## Review Focus

- Install line still points at old repo name anywhere in copied docs
- Structure check still requires plugin JSON files (would fail CI)
- `npx skills` fails to find skill if folder/name mismatch
- Old GitHub repo deleted before push/verify of new repo
- EXAMPLES/TESTS paths broken after move

---

### Task 1: Scaffold local `skills` repo and copy ado-boards

**Files:**
- Create: `/Users/koios/Personal/projects/skills/` (git repo)
- Create: `skills/ado-boards/**` (copy from ado-boards-skill)
- Create: `skills/ado-boards/EXAMPLES.md`, `skills/ado-boards/TESTS.md` (moved from old root)
- Create: `LICENSE`, `.gitignore`, `scripts/check-skill.sh`, `.github/workflows/check-skill.yml`
- Create: `README.md` (collection voice)
- Create: `docs/superpowers/specs/2026-10-23-skills-collection-design.md` (copy of approved design)

**Interfaces:**
- Consumes: current `ado-boards-skill` tree
- Produces: local repo ready to push; `bash scripts/check-skill.sh` → `OK`

- [ ] **Step 1: Init local repo** at `/Users/koios/Personal/projects/skills` via `create_repo`
- [ ] **Step 2: Copy** `skills/ado-boards` from ado-boards-skill; move EXAMPLES.md and TESTS.md under `skills/ado-boards/`; copy LICENSE; write `.gitignore` without requiring plugin files; adapt `check-skill.sh` (drop plugin JSON block; keep ado-boards az checks); copy CI workflow
- [ ] **Step 3: Write collection README** (personal tone, install command with `0xKoios/skills`, skill index table, linked-clone edit path, no Copilot plugin)
- [ ] **Step 4: Run** `bash scripts/check-skill.sh` — expect `OK: all skill checks passed`
- [ ] **Step 5: Initial commit** on `main`

### Task 2: Publish to GitHub and verify `npx skills`

**Files:** remote only

- [ ] **Step 1: Create** public GitHub repo `0xKoios/skills` and push `main` (`gh repo create`)
- [ ] **Step 2: Verify** `npx skills add 0xKoios/skills -l -y` lists `ado-boards`
- [ ] **Step 3: Optional smoke** `npx skills add 0xKoios/skills --skill ado-boards -g -y` (if user wants)

### Task 3: Delete old GitHub repo

- [ ] **Step 1: Confirm** Task 2 verify passed
- [ ] **Step 2: Delete** `0xKoios/ado-boards-skill` with `gh repo delete 0xKoios/ado-boards-skill --yes`
- [ ] **Step 3: Leave** local `ado-boards-skill` directory in place (user disposes later)
