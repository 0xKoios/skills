---
name: principle-subtract-before-you-add
description: "Apply when sequencing an addition, refactor, or rewrite. Remove dead code, unused imports, redundant validators, and stub references first, then build on the simpler base."
disable-model-invocation: true
---

# Subtract Before You Add

Before adding to a file or system, remove what is dead in the area you will touch. Then build on the smaller base. Default to subtraction, and leave the design simpler behind the same or a smaller surface.

**Why:** Dead code misleads. A reader, or an agent, sees an old exporter and copies its pattern, keeps its imports alive, or wonders whether the new code must stay compatible with it. Removing it first makes the addition smaller and its review obvious.

**Pattern:**
- **Survey before building.** In the files you will change, list functions with no callers, commented-out blocks, unused imports, and stubs. Confirm "no callers" with a search, not a guess.
- **Delete in its own step.** Remove the dead code first, as a separate commit or diff hunk, so the addition reviews cleanly. For example, drop a legacy HTML export nobody calls before adding a CSV export.
- **Cut before you polish.** Reach the minimum that works before investing in quality.
- **Design for observed use.** No validators, parsers, or guards beyond what the requirement demands.
- **Delete, don't stub.** When a reference or section has nothing new in it, remove it instead of leaving a placeholder.

**Not this:**
- Adding a CSV exporter next to an unused legacy exporter and a commented-out XML stub, leaving all three for the next reader to sort out.

<!-- Adapted from pstack/skills/principle-subtract-before-you-add/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: remove before building, cut before polish, design for observed use, delete rather than stub. Changed: dropped the prompt-specific bullet, added Why, a survey-then-delete step with a search check, and an exporter example. -->
