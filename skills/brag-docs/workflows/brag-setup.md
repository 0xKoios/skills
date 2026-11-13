# Workflow: brag-setup

Goal: create or refresh `~/.config/brag-docs/config.md` (Windows: `%USERPROFILE%\.config\brag-docs\config.md`) from `../config.template.md`. No secrets in the repo copy — user config lives only under `~/.config/brag-docs/`.

Run when config is missing, the user asks to set up brag docs, or store/scan preferences changed.

## Core (first run or refresh)

1. **Store** — ask where entries should go [default: **markdown**]:
   - **markdown** — local file (default).
   - **notion** — append to an existing page (URL or id).
   - **chat-only** — pasteable markdown in chat; no file or Notion write.
2. **Target** — only if needed:
   - Markdown: **Store path** (suggest `~/brag-docs/YYYY.md` for the year they want; confirm expanded path).
   - Notion: **Notion target** (page URL or id — link existing page only; no heading scaffold in v1).
   - Chat-only: skip path/Notion fields (leave **Store path** and **Notion target** as `not set yet`; **Store** `chat-only` is enough).
3. **Scan default** — how **brag-backfill** may use **Scan** (git, `gh`, boards) [default: **ask each time**]:
   - `off` — interview only.
   - `ask each time` — confirm before each backfill scan.
   - `on when tools exist` — scan when tools are available unless the user declines for that run.

4. **Write** — show the filled config (use `not set yet` for fields not chosen yet). After explicit **yes**, write **only** under `~/.config/brag-docs/` (or Windows equivalent) — not into the skill repo. Anything other than yes → **done**; config file unchanged.

Done when the config file exists and the user has a next step — or when they declined the write. Suggest: **`brag-capture`** for a first win.

## On first need

When a later workflow hits `not set yet` for Store path or Notion target: collect the value, preview the config addition, write after **yes**, continue. User says **skip** → keep `not set yet` for that field; **this run** is paste-only (no file, no Notion, no invented path). Do not continue into a persist step for that run.

Rerun core when the user changes store type or scan default.
