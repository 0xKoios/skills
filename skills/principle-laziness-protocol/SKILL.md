---
name: principle-laziness-protocol
description: "Apply when refactoring, judging diff size, or tempted to add abstractions, layers, options, or features nobody asked for. Bias toward deletion and the smallest change that solves the problem."
disable-model-invocation: true
---

# Laziness Protocol

Write the minimum code that solves the stated problem. Build what was asked and nothing speculative: no extra features, no abstraction for single-use code, no configurability nobody requested, no handling for states that can't happen. Make each decision once, in one place.

**Why:** Every line costs reading, testing, and upkeep. Speculative code is paid for now and used rarely. When the real need arrives, it seldom matches the guess, so the early abstraction gets rewritten anyway.

**Pattern:**
- **Smallest diff wins.** Fewer plain lines beat elegant boilerplate. If 200 lines could be 50, rewrite them as 50.
- **Build the asked core, decline the extra.** A requested cache is a dict with an expiry inside the existing function. When the request also floats a framework "for later", build the core and decline the framework in one line with the reason: there is one case today, and the second case will show the real shape.
- **No abstraction for one use.** Three similar lines beat a premature helper. Add the interface when a second implementation exists.
- **Consolidate decisions.** If the same choice appears in several places, give it one source of truth and pass the result down as a plain value.
- **Handle errors that can happen.** Guard real failure modes such as network, input, and missing files. Skip guards for states the code already rules out.
- **Run the senior-engineer test.** Ask "would a senior engineer call this overcomplicated?" If yes, simplify before showing it.

**Not this:**
- Adding a backend registry, adapter classes, and a config flag around a ten-line in-memory cache because "we might want Redis later".

<!-- Adapted from pstack/skills/principle-laziness-protocol/SKILL.md (cursor/plugins, MIT, Lauren Tan) and section 2 "Simplicity First" of the user's CLAUDE.md (0xKoios/skills, MIT, 0xKoios). Took: consolidate decisions, minimize the diff, no speculative features or abstractions, the senior-engineer test. Changed: merged the two into one rule, added Why, a decline-the-extra pattern, and a general example. -->
