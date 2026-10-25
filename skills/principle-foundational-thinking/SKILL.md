---
name: principle-foundational-thinking
description: "Apply before writing logic: choosing core types and data structures, sequencing scaffold versus feature work, or deciding what concurrent actors share. Get the data structures right so the code that follows becomes obvious."
disable-model-invocation: true
---

# Foundational Thinking

Settle the data shapes before the logic. Define the core types, trace every access pattern, and choose structures that fit the dominant paths. Then decide what state concurrent actors share and who owns it. Structural decisions protect option value. Code-level decisions protect simplicity.

**Why:** Logic follows data. A wrong shape forces a workaround into every function that touches it, and fixing it later means rewriting all of them. Shared mutable state between actors is where races come from, and it is cheapest to rule out before the first line of logic.

**Pattern:**
- **Write the core types first.** For a room-booking service that means Room, Reservation, Hold, and their invariants, plus who reads and writes each one. Lay the types and their owners out in your reply before writing any logic, because a shape is cheap to correct until code depends on it.
- **Ask the concurrency question.** For every piece of shared state, ask "what happens if another actor changes this at the same time?" If the answer isn't "nothing", isolate it: one owner, a queue in front of it, or immutable snapshots.
- **Scaffold first.** Anything every later phase benefits from goes first: CI, tests, lint, shared types. Setup before features, tests before fixes.
- **DRY the structure, not every line.** Types and data models should converge. Three similar statements still beat a premature abstraction.
- **Deepen one abstraction per increment.** Each step lands or deepens a coherent abstraction instead of spreading special cases across callers.
- **Subtract first.** Remove dead code before laying foundations, per `../principle-subtract-before-you-add/SKILL.md`.

**Not this:**
- Opening with the booking endpoint and finding halfway through that two requests can reserve the same room.

<!-- Adapted from pstack/skills/principle-foundational-thinking/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: data structures first, the concurrency question, scaffold first, DRY the structure. Changed: restated as one rule with Why, Pattern and Not this, and added a worked example of core types. -->
