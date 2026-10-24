---
name: principle-separate-before-serializing-shared-state
description: "Apply when concurrent workers, processes, or agents might write to the same file, key, table, branch, or state object, or when someone asks for a lock. First remove the shared write target by giving each writer its own output; serialize structurally only when one shared writer is a real invariant."
disable-model-invocation: true
---

# Separate Before Serializing Shared State

When concurrent actors might share mutable state, first ask whether they need the same object at all. Usually they don't, so give each one its own and merge at the end. When one shared target is truly required, enforce serialization in structure, not in instructions.

**Why:** Concurrent writes cause races that are intermittent and hard to reproduce. A lock fixes the race but adds contention, deadlock risk, and stale-lock cleanup, and it serializes workers that never needed to coordinate.

**Pattern:**
- **Name the shared state.** List what more than one actor writes: files, keys, rows, branches, and caches.
- **Ask whether it's one object or independent facts.** Workers that each produce results are publishing independent facts.
- **Default to separate targets.** Give each actor its own file, key, partition, or branch, such as `results/worker-1.json`, and merge at read or report time. One file with a field per worker is still shared.
- **Serialize only for a real invariant,** such as one counter or one canonical ledger. Use a structural mechanism: a single-writer process, sequential phases, an atomic compare-and-swap, or a lock file with stale-lock handling.
- **Instructions are not concurrency control.** A comment saying "only one worker writes at a time" stops nothing.

**Not this:**
- Wrapping every append to `results.json` in a file lock when each worker could write its own file and a final step could merge them.

<!-- Adapted from pstack/skills/principle-separate-before-serializing-shared-state/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: eliminate sharing before serializing, independent facts vs one canonical object, per-actor ownership merged at read time, structural serialization, a lock as a smell. Changed: added the cost-of-a-lock reason, the instructions-aren't-control bullet and a Not this, replaced the state.json example with a general results one. -->
