---
name: principle-make-operations-idempotent
description: "Apply when designing commands, jobs, loads, lifecycle steps, or processing loops that can crash, retry, be rerun, or be run for a past date. Each run converges to the same end state however many times it runs and wherever the last run stopped."
disable-model-invocation: true
---

# Make Operations Idempotent

Design every state-changing operation to converge on the correct state, however many times it runs and wherever the previous run stopped. Rerunning it, or running it for a past date, gives the same result as running it once.

**Why:** Crashes, retries, scheduler double-fires, and manual backfills are normal. When leftover state changes the next run's outcome, every rerun becomes a cleanup job, and a backfill silently doubles the data.

**Pattern:**
- **Ask the three questions.** What happens if this runs twice in a row? What happens if the last run crashed at each possible point? Does a rerun converge on the same end state? "It depends on what was left behind" means the operation needs fixing.
- **Replace, don't append.** A run owns its slice, such as a date partition or a batch id. Overwrite that slice (delete then insert in one transaction, or a partition overwrite), or merge on a natural key. A plain append duplicates rows on every rerun.
- **Derive steps from current state.** Read what exists, compare it to the goal, and apply only the difference. A repeat then finds nothing to do.
- **Take the date as input.** The run date is a parameter, never "today", so running for a past date reproduces that day exactly.
- **Make leftovers recognizable.** Locks, temp files, half-written records, and claimed jobs must be judged stale from evidence the next run can check. Write to a temp path and rename into place, and compare artifacts by content, not by creation order.
- **Test it.** Run it twice on the same input and assert the output is identical.

**Not this:**
- A webhook handler that inserts a charge for every delivery it receives, so the provider's automatic retry bills the customer twice.

<!-- Adapted from pstack/skills/principle-make-operations-idempotent/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: converge regardless of prior partial runs, derive steps from existing state, stale-leftover evidence, temp-and-rename, the three-question test. Changed: added the user's rule that reruns and past-date runs converge, the replace-not-append and date-as-input bullets, and a run-twice test. -->
