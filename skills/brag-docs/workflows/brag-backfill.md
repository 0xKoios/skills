# Workflow: brag-backfill

Goal: reconstruct **Entries** for a time range, then persist with **brag-capture**’s Preview and write gate. Optional **Scan** when config and user allow and tools exist; otherwise finish via interview. How: read config; draft with `../references/evidence-and-categories.md`.

## Before work

1. Read config. Missing → **`brag-setup`** first.
2. **Time range** — confirm explicitly (e.g. “last week”, “March 2026”, “Q3”). Do not scan until the range is agreed.
3. **Store** and target — same as capture; collect on first need (user may **skip** — field stays `not set yet`).

## Scan (optional)

Respect **Scan default** from config:

| Scan default | Behavior |
|---|---|
| `off` | Skip scan; go to interview. |
| `ask each time` | Offer scan; proceed only if user agrees for this run. |
| `on when tools exist` | Try available tools; user may still decline. |

Before scanning: confirm **which sources** to try (local git log, `gh pr list`, board queries, etc.) for the agreed range. If a tool is missing or auth fails, say so and continue without it.

**Scan output is draft input only** — group related commits/PRs/cards into one **Entry** where it tells one story; preserve user voice. Dates, links, and numbers come from scan output or stay `(evidence needed)`.

If scan is skipped, unavailable, or thin → **interview** for the same range (“What shipped? What broke and you fixed? Who did you unblock?”). Backfill without scan must still complete via interview. Prefer an honest gap over fluff — zero **Entries** after scan and interview is a valid **done** (say so).

## Draft and categorize

1. Merge scan signals and interview answers into candidate accomplishments.
2. Assign a primary **category** when helpful (`shipped`, `bugfix`, `collaboration`, `infra`, `docs`, `other`) — mainly for grouping in preview.
3. Draft each as an **Entry** per `../references/evidence-and-categories.md`.

## Preview and write

Follow **Preview and write** in `brag-capture.md` (same persist gate). Then write footer with count/range covered and suggest **`brag-capture`** for the next single win.

Done when that gate completes for the agreed range (including declined preview or zero entries).
