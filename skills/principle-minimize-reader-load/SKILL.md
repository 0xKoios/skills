---
name: principle-minimize-reader-load
description: "Apply when reviewing or shaping code that's hard to trace. Count the layers between a question and its answer and the hidden state a reader must hold; collapse one-caller wrappers and shrink mutable scope."
disable-model-invocation: true
---

# Minimize Reader Load

Maintainability is the work a reader must do to understand the code. Measure it on two independent axes: **layers to trace** (indirections between the question and the answer) and **state to hold** (hidden or mutable context kept in the reader's head). Cut whichever is high. Line counts and "clean architecture" are only proxies.

**Why:** Working memory is finite. A six-layer adapter stack and a flat file with fifty globals are equally hard to reason about. Every layer that only forwards a call costs a reader a jump and gives nothing back.

**Pattern:**
- **Collapse layers that cost more than they save.** Inline wrappers with one caller, adapters with one implementation, and helpers that rename a single expression. Name each one and its single caller when you flag it.
- **Make each layer change the abstraction.** A layer that repeats the methods and arguments of the one below it is a pass-through. Remove it.
- **Prefer interfaces that hide real decisions.** A broad interface over little logic makes readers learn both the surface and the implementation.
- **Shrink state scope.** Prefer returns over mutation, locals over fields, fields over module state, and module state over globals. Derive values instead of syncing copies.
- **Name invariants at the boundary,** once, instead of in every consumer.
- **Run the 30-second test.** A new reader should answer "where does X come from?" and "what can change X?" in under 30 seconds. Add a layer or piece of state only if it removes at least as much load elsewhere.

**Not this:**
- Keeping a `ClientFactory`, a `ClientProvider`, and a `get_client()` helper "for flexibility" when one function creates the only HTTP client.

<!-- Adapted from pstack/skills/principle-minimize-reader-load/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: the two axes, collapse one-caller layers, interface compression, shrink state scope, the 30-second test. Changed: tightened the prose, added Why and a Not this, and dropped the context-window cross-link. -->
