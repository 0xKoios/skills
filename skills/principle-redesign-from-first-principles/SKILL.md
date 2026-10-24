---
name: principle-redesign-from-first-principles
description: "Apply when integrating a new requirement into an existing design."
disable-model-invocation: true
---

# Redesign from First Principles

Don't bolt a new requirement onto the current design. Redesign as if the requirement had been a founding assumption, then deliver that design in small verified steps.

**Why:** A bolted-on branch makes the next change harder. Special cases multiply: one `if currency == "EUR"` today becomes a branch in every function that touches money, and each new currency repeats the work. Folding the requirement into the core model keeps one code path.

**Pattern:**
- **Read every affected file first.** Understand the current design before changing it.
- **Ask the from-scratch question.** "If we wrote this today with the new requirement, what would we build?" Usually the answer is a field or type in the core model, such as a Money value that carries amount and currency, not a branch.
- **Name what the redesign settles.** For money: which currency a total is in, where conversion happens, and how each currency rounds and formats.
- **Propagate through every reference.** Types, call sites, tests, docs, and examples all move to the new model.
- **Deliver incrementally.** Plan the whole redesign, then land it in steps that each pass the tests.
- **Stay proportional.** Build the simplest model that holds the requirement natively, per `../principle-laziness-protocol/SKILL.md`.

**Not this:**
- Adding `if currency == "EUR":` beside the existing logic and copying the rest of the function into the branch.

<!-- Adapted from pstack/skills/principle-redesign-from-first-principles/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: redesign as if the requirement were foundational, read first, propagate everywhere, deliver incrementally. Changed: added Why, a money example, a proportionality guard, and a Not this. -->
