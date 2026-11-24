# Evidence and categories

Use when drafting **Entries** for **brag-capture**, **brag-backfill** or **brag-review**. An **Entry** is action → result → evidence (`../GLOSSARY.md`).

## Rewrite a rough note

Users type activity ("fixed the login thing", "helped Ana with billing"). Turn it into an **Entry**:

1. **Action** — active verb, the specific thing done, in the user's words.
2. **Result** — who benefited or what changed. Ask if it is not in the note.
3. **Evidence** — the strongest rung below the user can name.

Keep the user's voice and scope. Numbers, names and links come only from the user; a missing one stays missing.

## Evidence ladder

Prefer the strongest evidence available; otherwise `(evidence needed)`.

| Rank | Kind | Examples |
|---|---|---|
| 1 | **Metric** | Latency −40%, 0 Sev-1 in Q3, 12 teams adopted |
| 2 | **Reference** | Ticket ID, PR number, doc title, dashboard name |
| 3 | **Observable outcome** | Feature live in prod, runbook used in incident, Team X unblocked |
| 4 | **Qualitative + context** | Who asked for it, what was broken before, scope/constraints |
| 5 | **Evidence needed** | `(evidence needed)` — leave the gap visible and save the entry |

**Evidence the user almost always has** — offer these when they say "I have no proof": the ticket ID, the date it closed, who asked for it, what was broken or slow before. Each is rank 2–4.

Ask for evidence **once** per entry. No answer → mark `(evidence needed)` and move on; **brag-review** asks again only for entries picked for a review.

## Anti-patterns

| Weak | Strong |
|---|---|
| "Fixed a bug in auth" | "Fixed token refresh race → users stay signed in mid-session → ticket 4821" |
| "Worked on dashboards" | "Built latency dashboard → on-call spots P95 spikes in minutes → live in prod" |
| Invented metric: "saved 40% of eng time" | Ask: "Rough number, or keep it qualitative?" |
| One entry per ticket on the same feature | One entry for the feature, highest-impact framing |
| Passive: "The pipeline was improved" | Active: "Rebuilt the CI pipeline → release checks finish before lunch" |
| List of technologies used | The outcome the technology produced |
| Dropping a weak entry silently | Keep it, mark `(evidence needed)`, show it in preview |
| Co-authored work written as solo | Ask: "Your work, shared, or skip?" and say "with X" when shared |

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
shipped | Reduced checkout API p99 latency → p99 from 820ms to 490ms over two weeks → PR 1234
```

**Example with missing proof:**

```text
collaboration | Paired with design on onboarding flow → shipped revised wizard in staging → (evidence needed)
```

In markdown files, workflows may use bullets or headings per year doc convention; the action → result → evidence contract still applies.
