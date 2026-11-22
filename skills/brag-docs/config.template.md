# brag-docs config

Template only. Setup (`workflows/brag-setup.md`) copies this to the config path in `SKILL.md` §1 and fills it in. Shared across agents. Leave this file blank of secrets — it ships in a public repo.

The agent has no memory between chats; this file is how it remembers where to write. Values marked `not set yet` are collected the first time a workflow needs them.

## Store (core setup)

Where entries are persisted.

- Store: markdown
  (`markdown` | `notion` | `chat-only` — chat-only shows pasteable markdown; no file or Notion write)

## Store owner (core setup)

Who owns the device or account holding the store.

- Store owner: personal
  (`personal` | `work` — personal generalizes entries per `references/personal-store.md`)

## Store path (when Store is markdown)

- Store path: not set yet
  (e.g. `~/brag-docs/2026.md` — confirm before first write; use the year the user wants)

## Notion target (when Store is notion)

- Notion target: not set yet
  (page URL or id — link existing page only; no heading scaffold in v1)
