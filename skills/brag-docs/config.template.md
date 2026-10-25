# brag-docs config

Template only. Setup (`workflows/brag-setup.md`) copies this to `~/.config/brag-docs/config.md` (Windows: `%USERPROFILE%\.config\brag-docs\config.md`) and fills it in. Shared across agents. Leave this file blank of secrets — it ships in a public repo.

The agent has no memory between chats; this file is how it remembers where to write and how dig should behave. Values marked `not set yet` are collected the first time a workflow needs them.

## Store (core setup)

Where entries are persisted.

- Store: markdown
  (`markdown` | `notion` | `chat-only` — chat-only shows pasteable markdown; no file or Notion write)

## Store path (when Store is markdown)

- Store path: not set yet
  (e.g. `~/brag-docs/2026.md` — confirm before first write; use the year the user wants)

## Notion target (when Store is notion)

- Notion target: not set yet
  (page URL or id — link existing page only; no heading scaffold in v1)

## Dig default (core setup)

Whether backfill may scan external signals without asking every time.

- Dig default: ask each time
  (`off` | `ask each time` | `on when tools exist` — dig never required for capture)
