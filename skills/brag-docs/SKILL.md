---
name: brag-docs
description: >-
  Brag document. Use when the user finishes work and wants to note it, rewrite
  what they did into an impact entry, backfill accomplishments for a time
  range, or prep a performance review, self-review or promo packet from their
  brag doc.
license: MIT
---

# Brag docs

Help one person maintain a **Brag document** — a durable record of accomplishments, written from what the user types. **Store** preferences live in **config**; the same skill fits markdown, Notion, or chat-only.

## 1. Before anything else

1. **Read config** — `~/.config/brag-docs/config.md` (Windows: `%USERPROFILE%\.config\brag-docs\config.md`). Missing → run **`brag-setup`** (`workflows/brag-setup.md`) first; guessing store or path writes to the wrong place. Values marked `not set yet` are collected the first time a workflow needs them.
2. **Open the matching workflow** (table below) and follow it. Rules in §2 bind every workflow.

Done when config is in hand and the workflow file is open.

User config stays on their machine. Credentials and tokens stay out of chat and out of the repo.

## 2. Rules

| Rule | Criterion |
|---|---|
| **Typed input** | Every fact comes from what the user types in this chat or from their own **Store**. Ask the user; tickets, boards and repos stay unread. |
| **Entry** | Draft **Entries** per `references/evidence-and-categories.md` (terms: `GLOSSARY.md`). |
| **Personal store** | **Store owner** `personal` → generalize every draft per `references/personal-store.md` before preview. |
| **Append-only** | Append to the configured **Store**; edit existing lines only when the user asks. |
| **Preview** | Before any write: show drafts with evidence gaps; wait for explicit **yes**. Anything other than yes leaves the store unchanged. |
| **Write footer** | After a write: what was appended, where, one next step. Chat-only: paste instructions only. |

## 3. Workflows

| When | Open |
|---|---|
| Set up brag docs; config missing; store preferences changed | `workflows/brag-setup.md` |
| Just finished something; turn a rough note into **Entries** | `workflows/brag-capture.md` |
| Backfill a time range from memory | `workflows/brag-backfill.md` |
| Prep a performance review, self-review or promo packet | `workflows/brag-review.md` |

## 4. Reference

- Domain terms: `GLOSSARY.md`
- When drafting **Entries**: `references/evidence-and-categories.md`
- When **Store owner** is `personal`: `references/personal-store.md`
