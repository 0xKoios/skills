---
name: principle-encode-lessons-in-structure
description: "Apply when you catch yourself writing the same instruction a second time, or keep correcting the same mistake. Encode the rule as a lint rule, CI or pre-commit check, type, runtime assertion, or script whose error names the fix, instead of adding more text."
disable-model-invocation: true
---

# Encode Lessons in Structure

When a lesson repeats, turn it into structure: a lint rule, a CI or pre-commit check, a type, a runtime assertion, or a script. Make its error message name the fix. Add more instructions only when the rule needs judgment that no check can make.

**Why:** Instructions get skimmed, forgotten, and diluted as the doc grows. A check fires every time, for every agent and every person, and nobody has to remember it.

**Pattern:**
- **The repeat is the trigger.** The second time you write or say the rule, stop writing prose and build the check.
- **Pick the cheapest enforcer.** Use an existing linter rule first (ruff's `T20` bans `print`, ESLint has `no-console`), then a grep in CI or a pre-commit hook, then a type or runtime check.
- **Make the error teach.** The message names the fix, such as "use logger.info, not print, in library code", so whoever hits it corrects course without reading docs.
- **Scope it to where the rule holds,** such as library code but not scripts or tests, so the check never fires on valid code and gets ignored.
- **Delete the instruction once the check exists.** The instruction was the symptom, and keeping both splits the source of truth.
- **When it can't be encoded,** make the instruction prominent and add an example of the failure.

**Not this:**
- Adding a fourth bolded "NEVER use print()" line to the agent instructions file.

<!-- Adapted from pstack/skills/principle-encode-lessons-in-structure/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: encode a repeated instruction as structure, the instruction is the symptom, the judgment-needed fallback. Changed: wrote the rule, Why and steps (cheapest enforcer, error names the fix, scope it), and the print() example. -->
