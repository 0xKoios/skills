---
name: principle-sequence-verifiable-units
description: "Apply to multi-step work (sweeps, migrations, runs of similar edits) and to how you stack commits and PRs. Break the work into small units that each end in a check, get each one green before starting the next, and order delivery so the sequence proves itself to a reviewer."
disable-model-invocation: true
---

# Sequence Verifiable Units

Split the work into small units that each end in a state you can check. Don't start the next unit until the current one is green.

**Why:** A break caught at the unit that caused it is cheap to find. A break caught after a batch is buried, and you have already built more on a broken base. The same units, delivered in order, let a reviewer watch the work go red, then green, instead of trusting you.

**Pattern:**
- **Start from green.** Rebase onto a clean trunk and run the checks first, so every later check measures against a real baseline.
- **One unit is a bracket:** a known-good state, one change, the check, then the next unit. Size it so a failure points to one cause, such as one endpoint or one module.
- **Do the first unit by hand,** then let a script or codemod do the rest, per `../principle-build-the-lever/SKILL.md`. Run the per-unit check anyway, because it's nearly free.
- **Stop on red.** Fix the failing unit before advancing. Never carry failures forward to sort out at the end.
- **Make each check real,** per `../principle-prove-it-works/SKILL.md`. A unit is done when its check ran and passed, not when the edit is written.
- **Stack the delivery as an argument.** Put the failing test first, then the fix. Other good orders are the subtraction before the reshape, the baseline before the treatment, and the scaffold before the feature. Each commit stands on its own.

**Not this:**
- Moving all 30 endpoints to the new middleware, then running the suite once and facing 11 failures with no idea which change caused which.

<!-- Adapted from pstack/skills/principle-sequence-verifiable-units/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: small units ending in a check, don't advance until green, rebase onto clean trunk, stack commits as an argument, the lever and prove-it-works links. Changed: restated as Pattern bullets, added stop-on-red, unit sizing, first-unit-by-hand and a Not this. -->
