# Data change

Any change to a pipeline, model, or table, including a wrong-number fix and a backfill. It holds every data-specific rule, and it works with any tool or warehouse.

**Subagents:** Step 2's lookups of downstream tables, jobs, and dashboards go to read-only subagents. The builds in steps 5 and 6 go to fresh subagents with pointer briefs: the spec or repro, the seam, the test command, and the branch. Questions, gates, and step 7's backfill decision stay in the main chat, because they're the user's calls. You run step 9 yourself.

1. Classify the change, name its flow in one line, and follow the matching flow.
   - **A new or changed pipeline** follows the Feature flow: run steps 1 to 5 of `feature.md` (questions, spec, data shape, plan, gate check) before step 5 here, and cover steps 2 to 8 in the spec. The gates apply as in **Gates** in the router.
   - **Wrong numbers** follow the Bug fix flow with no questions: reproduce with the data repro methods below, then debug per `../references/debugging.md`.
   - **A behavior-preserving restructure of pipeline code** follows `refactoring.md`, with step 6's run-twice test as part of its behavior pin, because a restructure can break reruns without changing a single run's output.
   - **A backfill-only task** goes straight to step 7.
2. List the downstream tables, jobs, dashboards, and consumers of what you'll change (`../../principle-look-before-you-write/SKILL.md`).
3. Place the change in the Bronze → Silver → Gold layering. State a reason for any other layering, and keep each layer to one job, so a fix in one layer doesn't ripple into the others.
4. Keep schema changes additive. Renames and drops go through deprecation and moving consumers first (`../../principle-boundary-discipline/SKILL.md`, `../../principle-migrate-callers-then-delete-legacy-apis/SKILL.md`), because a consumer you didn't move breaks silently.
5. Write the tests first at a data seam: a transformation function, a SQL model on fixture data, or a schema contract check (`../references/tdd.md`).
6. Give every job a "run it twice, same result" test (`../../principle-make-operations-idempotent/SKILL.md`).
7. State the backfill's date range and cost, and run it only after the user's yes (see **Escalation** in the router).
8. Add freshness, row-count, null, and duplicate checks, and name who gets alerted when one fails.
9. Run the data verification: narrate the flow through each stage, show the transforms step by step, check freshness, counts, and the contract, and preview any prod write. Quote the command behind every number (`../../principle-explain-the-number/SKILL.md`).
10. Run **Opening a PR**.

## Data repro methods

Used in step 1 and by Bug fix when the bug is in data:

- **Rerun one partition or date** and compare the result with what the user expected.
- **Query a sample** of the affected rows.
- **Diff expected rows against actual** for one key range or date.

Probes run on dev or sample data only. A probe against prod can change what consumers read, so ask the user instead and say what you wanted to check (`../../principle-look-before-you-write/SKILL.md`).

**Reply:** the flow taken, the downstream list, the layering and contract decisions, the tests and their results, the backfill question or its answer, the checks added and who gets alerted, and the verification narration with each number's command.
