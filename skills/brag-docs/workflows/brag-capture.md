# Workflow: brag-capture

Goal: turn fresh notes or a short interview into one or more **Entries** and persist them to the configured **Store** (or paste when chat-only). How: read `~/.config/brag-docs/config.md`; shape drafts with `../references/evidence-and-categories.md`.

**Dig** is not used here — only user notes and interview.

## Before intake

1. Read config. Missing file → **`brag-setup`** (`brag-setup.md`) first.
2. Confirm **Store** and target (path or Notion page). Values `not set yet` → collect per setup **on first need** (user may **skip** — field stays `not set yet`).

## Intake

Accept whatever the user brought: bullets, paste, “I shipped X today”, or silence.

If detail is thin, run a **short interview** (stop when you can draft **Entries**):

- What did you do? (**action**)
- Who benefited or what changed? (**result**)
- What proof exists? (**evidence**)

Optional: ask for a **category** (`shipped`, `bugfix`, `collaboration`, `infra`, `docs`, `other`); skip if the user does not care.

## Draft

For each accomplishment, draft **Entries** per the evidence reference. Call out ladder gaps in the preview (activity-only → ask once more or mark `(evidence needed)`).

Use the one-liner shape from the reference when helpful; bullets or headings are fine for markdown **Store** files.

## Preview and write

This section is the **persist gate** for capture and for **brag-backfill** (which points here).

1. Show all draft **Entries** with gaps labeled. Wait for explicit **yes**. Anything other than yes → **done**; store unchanged.
2. On **yes**:
   - If **Store** is **markdown** and **Store path** is still `not set yet`, or **Store** is **notion** and **Notion target** is still `not set yet` (including after skip): show pasteable markdown and **stop**; do not create a file, write Notion, or substitute a path such as `~/brag-docs/YYYY.md`.
   - **markdown** — append-only to **Store path** (create parent dirs if needed; edit existing lines only when the user asked).
   - **notion** — append when Notion tools/auth exist; otherwise show pasteable markdown and say sign-in or fix target.
   - **chat-only** — show pasteable markdown and **stop**.
3. **Write footer** — what was appended (or pasted), where, one next step (e.g. another capture). Chat-only: paste instructions only.

Done when the user has approved drafts and persistence (or paste) matches config — or when they declined preview.
