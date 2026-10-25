---
name: brag-docs
description: >-
  Brag document. Use when the user wants to set up brag docs, capture a win
  into their brag document, or backfill a time range of accomplishments.
  Optional scan on backfill; markdown, Notion, or chat-only store.
license: MIT
---

# Brag docs

Help one person maintain a **Brag document** — a durable, evidence-backed record of accomplishments. **Store** and **Scan** preferences live in **config**; the same skill fits markdown, Notion, or chat-only.

## 1. Before anything else

1. **Read config** — `~/.config/brag-docs/config.md` (Windows: `%USERPROFILE%\.config\brag-docs\config.md`). Missing → run **`brag-setup`** (`workflows/brag-setup.md`) first; guessing store or path writes to the wrong place. Values marked `not set yet` are collected the first time a workflow needs them.
2. **Open the matching workflow** (table below) and follow it. Rules in §2 bind every workflow.

Done when config is in hand and the workflow file is open.

User config stays on their machine. Credentials and tokens stay out of chat and out of the repo.

## 2. Rules

| Rule | Criterion |
|---|---|
| **Entry** | Draft **Entries** (see `GLOSSARY.md` and `references/evidence-and-categories.md`). Use user- or scan-sourced numbers and links; otherwise `(evidence needed)`. |
| **Append-only** | Append to the configured **Store**; edit existing lines only when the user asks. |
| **Preview** | Before any write: show drafts with evidence gaps; wait for explicit **yes**. Anything other than yes leaves the store unchanged. |
| **Scan** | **Scan** is for **brag-backfill** only when tools exist and config/user allow it. Confirm time range and sources before scanning. |
| **Write footer** | After a write: what was appended, where, one next step. Chat-only: paste instructions only. |

## 3. Workflows

| When | Open |
|---|---|
| Set up brag docs; config missing; store or scan preferences changed | `workflows/brag-setup.md` |
| Capture a win; turn notes into **Entries** | `workflows/brag-capture.md` |
| Backfill a time range; optional scan then interview | `workflows/brag-backfill.md` |

## 4. Reference

- Domain terms: `GLOSSARY.md`
- When drafting **Entries**: `references/evidence-and-categories.md`
