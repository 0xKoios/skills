---
name: principle-attack-the-premise
description: "Apply when two or more fixes that share one premise have failed the same check. Write the premise down and test it directly before writing another fix that assumes it."
disable-model-invocation: true
---

# Attack the Premise

When two or more fixes built on the same belief have failed the same check, suspect the belief, not the fixes. This questions a fact the current work assumes, unlike `../principle-redesign-from-first-principles/SKILL.md`, which rebuilds a design around a new requirement. Write the premise down and test it directly before any further fix.

**Why:** Each failed fix is evidence against the premise it assumed. A third fix on the same premise spends effort where the evidence already says the cause isn't.

**Pattern:**
- **Write the premise down.** It is the one sentence every failed fix assumed, for example "the memory leak is in the image decoder".
- **Test it directly.** Find an observation that would come out differently if the premise were false, and make it. For a suspected decoder leak: run the same load with decoding stubbed out and see whether memory still grows, or diff two heap snapshots. Look at how the failures are distributed, not only how big they are.
- **Make the test rerunnable.** A small script beats a one-off manual check, per `../principle-build-the-lever/SKILL.md`.
- **Follow the evidence.** If it contradicts the premise, the cause is elsewhere: look for what the failures share that the premise didn't predict. If it confirms the premise, ask the next "why" (Fix Root Causes), because the earlier fixes may have treated a symptom.
- **Remove the condition instead of compensating for it.** A cleanup step that runs after the cause leaves the cause in place and adds work on every run, per `../principle-laziness-protocol/SKILL.md`.

**Not this:**
- Trying a third buffer-pool tweak in the decoder because "it must be the decoder".

<!-- Adapted from pstack/skills/principle-attack-the-premise/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: suspect the shared premise, write it down, test it directly, follow the evidence, remove the condition. Changed: "gate" became "check", added a memory-leak example and a Not this, and linked only leaves in this set. -->
