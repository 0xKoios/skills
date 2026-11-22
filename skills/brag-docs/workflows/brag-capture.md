# Workflow: brag-capture

Goal: turn a rough note the user just typed into one or more **Entries** and persist them to the configured **Store** (or paste when chat-only). How: read config (`../SKILL.md` §1); shape drafts with `../references/evidence-and-categories.md`.

## Before intake

1. Read config. Missing file → **`brag-setup`** (`brag-setup.md`) first.
2. Confirm **Store** and target (path or Notion page). Values `not set yet` → collect per setup **on first need** (user may **skip** — field stays `not set yet`).

## Intake

Accept whatever the user typed: one line, bullets, a pasted ticket title, "I finished X today". Split it into separate accomplishments.

## Rewrite

For each accomplishment, rewrite the note per **Rewrite a rough note** in the evidence reference. When result or evidence is missing, ask **one** combined question per accomplishment, offering the evidence the user almost always has:

> What changed because of this — and do you have a ticket ID, a date, or who asked for it?

Whatever the answer — including "nothing" — draft the **Entry** and mark remaining gaps `(evidence needed)`. Optional: tag a **category**; skip if the user does not care.

Check each draft against **Anti-patterns** in the evidence reference. **Store owner** `personal` → generalize per `../references/personal-store.md`.

## Preview and write

This section is the **persist gate** for capture and for **brag-backfill** (which points here). Rules **Preview**, **Append-only**, and **Write footer** in `../SKILL.md` §2 bind this gate.

1. Show all draft **Entries** with gaps labeled (and generalizations listed, for a personal store). Wait for explicit **yes** (§2 **Preview**).
2. On **yes**:
   - If **Store** is **markdown** and **Store path** is still `not set yet`, or **Store** is **notion** and **Notion target** is still `not set yet` (including after skip): show pasteable markdown and **stop**; do not create a file, write Notion, or substitute a path such as `~/brag-docs/YYYY.md`.
   - **markdown** — append-only to **Store path** (create parent dirs if needed; edit existing lines only when the user asked).
   - **notion** — append when Notion tools/auth exist; otherwise show pasteable markdown and say sign-in or fix target.
   - **chat-only** — show pasteable markdown and **stop**.
3. Apply §2 **Write footer**.

Done when the user has approved drafts and persistence (or paste) matches config — or when they declined preview.
