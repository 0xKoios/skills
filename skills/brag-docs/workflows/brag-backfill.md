# Workflow: brag-backfill

Goal: reconstruct **Entries** for a past time range from the user's memory, then persist with **brag-capture**’s Preview and write gate. How: read config (`../SKILL.md` §1); draft with `../references/evidence-and-categories.md`.

## Before work

1. Read config. Missing → **`brag-setup`** first.
2. **Time range** — confirm explicitly (e.g. "last week", "March 2026", "Q3"). Do not interview until the range is agreed.
3. **Store** and target — same as capture; collect on first need (user may **skip** — field stays `not set yet`).

## Interview

Walk the range in chunks the user can recall (week by week for a month, month by month for a quarter or longer). For each chunk, prompt with the categories in the evidence reference:

- What shipped?
- What broke that you fixed?
- Who did you unblock, review for, or mentor?
- What did you build or document that others use?

The user may paste old notes, chat snippets or ticket titles; treat them as typed input. Stop a chunk when the user has nothing more. Prefer an honest gap over fluff — zero **Entries** for the range is a valid **done** (say so).

## Draft and categorize

1. Merge related answers into one accomplishment where they tell one story.
2. Rewrite each per **Rewrite a rough note** in the evidence reference — evidence asked once, gaps marked.
3. Assign a primary **category** when helpful — mainly for grouping in preview.
4. **Store owner** `personal` → generalize per `../references/personal-store.md`.

## Preview and write

Follow **Preview and write** in `brag-capture.md` (same persist gate). Then write footer with count/range covered and suggest **`brag-capture`** right after the next finished piece of work.

Done when that gate completes for the agreed range (including declined preview or zero entries).
