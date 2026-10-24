---
name: principle-outcome-oriented-execution
description: "Apply during planned rewrites and migrations with explicit phase boundaries. Converge on the target design; don't preserve smooth intermediate states with throwaway compatibility code."
disable-model-invocation: true
---

# Outcome-Oriented Execution

Optimize for the intended, verifiable end state, not for keeping every intermediate step smooth. When you control every caller, move them all to the new design and delete the old one in the same piece of work.

**Why:** Compatibility code written "just in case" outlives the case. An old loader kept alive beside the new one doubles the surface to test, lets new callers pick the wrong one, and turns a migration into a permanent fork. Correctness comes from verifying the end state, not from keeping both paths running.

**Pattern:**
- **Find every caller first.** Search the codebase so "internal" is a fact, not an assumption.
- **Converge.** Move each internal caller to the new design, delete the old path, and run the tests and the real entry points to prove it.
- **Declare planned breakage.** Say where a temporary break is acceptable during the migration and how it is reversed: the old code stays in version control.
- **Keep checks on touched areas.** Run high-signal tests for what each step changes, and the full static and runtime checks at the end.
- **Shim only for callers you can't change.** External consumers get a migrate-then-delete plan (Migrate Callers Then Delete Legacy APIs), with a removal date.

**Not this:**
- Keeping the old loader behind a flag or an auto-detecting wrapper "in case we need it", when every caller is in this repo.

<!-- Adapted from pstack/skills/principle-outcome-oriented-execution/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: end state over transitional stability, planned and reversible breakage, verify at the boundaries. Changed: turned Core rule and Guardrails into Pattern bullets, added find-every-caller, the internal versus external split, and a config-loader example. -->
