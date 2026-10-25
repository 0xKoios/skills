---
name: principle-never-block-on-the-human
description: "Apply when tempted to ask 'should I do X?' about reversible work such as editing code, renaming, writing tests, or splitting tasks. Decide, do it, and show the result. Irreversible actions still need a yes."
disable-model-invocation: true
---

# Never Block on the Human

For reversible work, decide, do it, and show the result. Don't ask "should I do X?". Do X and say why in one line, so the human can course-correct after the fact. This covers reversible work only. Irreversible actions wait for a yes, per the supervisor's Escalation section.

**Why:** The human supervises asynchronously. A question about a reversible step stalls the work for something a review comment could fix, while a wrong reversible choice costs only a revert.

**Pattern:**
- **Proceed, then present.** Make the change, run the relevant check, and report what you did and why.
- **Know what counts as reversible:** local, reviewable changes such as editing code, renaming, writing tests or notes, and splitting tasks. Force-pushing, deleting data, writing to production, sending messages, spending money, or anything that leaves the session is not.
- **Look it up instead of asking.** Facts in the code, docs, or history are yours to find.
- **Ask only about direction.** Product direction comes from the human. When a choice changes what gets built, ask one question. Execution itself doesn't block.
- **Note problems and keep going.** Log what you noticed and fix it in the next round instead of stopping.

**Not this:**
- Asking "should I split this 300-line function in two?" instead of splitting it, running the tests, and saying so.

<!-- Adapted from pstack/skills/principle-never-block-on-the-human/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: proceed then present, reversible proceeds and irreversible needs confirmation, product direction from the human, log and fix next round. Changed: limited the rule to reversible work, pointed irreversible actions to the supervisor's Escalation section, added the look-it-up and one-question bullets, dropped self-healing systems. -->
