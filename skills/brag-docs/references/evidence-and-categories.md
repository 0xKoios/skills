# Evidence and categories

Use when drafting **Entries** for **brag-capture** or **brag-backfill**. An **Entry** is action → result → evidence (`../GLOSSARY.md`).

## Evidence ladder

Prefer the strongest evidence available. Use user- or dig-sourced numbers and links; otherwise `(evidence needed)`.

| Rank | Kind | Examples |
|---|---|---|
| 1 | **Metric** | Latency −40%, 0 Sev-1 in Q3, 12 teams adopted |
| 2 | **Link** | PR, doc, ticket, dashboard URL |
| 3 | **Observable outcome** | Feature live in prod, runbook used in incident, test suite green |
| 4 | **Qualitative + context** | Stakeholder quote, scope/constraints that explain impact |
| 5 | **Evidence needed** | `(evidence needed)` — leave the gap visible |

If the user only has activity (“worked on X”), ask for result and evidence or mark `(evidence needed)`.

## Default categories

Optional on capture; useful to group backfill drafts. Pick one primary tag per entry when helpful.

| Category | Use for |
|---|---|
| **shipped** | Features, releases, user-visible delivery |
| **bugfix** | Defects, incidents, reliability fixes |
| **collaboration** | Cross-team work, mentoring, reviews, unblocking |
| **infra** | Platforms, CI, observability, tooling for others |
| **docs** | Runbooks, ADRs, guides, onboarding material |
| **other** | Everything else |

## Entry one-liner format

One line per entry when space is tight; expand in preview if the user wants detail.

**Shape:** `[category optional] **Action** → **Result** → **Evidence**`

**Example:**

```text
shipped | Reduced checkout API p99 latency → p99 from 820ms to 490ms over two weeks → https://github.com/org/repo/pull/1234
```

**Example with missing proof:**

```text
collaboration | Paired with design on onboarding flow → shipped revised wizard in staging → (evidence needed)
```

In markdown files, workflows may use bullets or headings per year doc convention; the action → result → evidence contract still applies.
