---
name: principle-surgical-changes
description: "Apply when editing existing code, especially for a small fix or a narrow request. Change only what the task needs, match the existing style, mention unrelated problems without fixing them, and clean up only your own leftovers."
disable-model-invocation: true
---

# Surgical Changes

Touch only what the task needs. Every changed line traces directly to the request. Problems you notice along the way get mentioned in your reply, not fixed in the diff.

**Why:** Unrequested edits hide the real change in noise, make review slower, and can break things nobody asked you to touch. The person reviewing an off-by-one fix shouldn't also have to check a rename sweep.

**Pattern:**
- **Change the minimum.** Fix what was asked, everywhere it occurs within that scope, and stop. For a wrong constant, fix every use of that one constant and nothing else.
- **Match the existing style,** even where you would write it differently: quotes, naming, formatting, and comment tone.
- **Mention, don't fix.** Unrelated dead code, unused imports, or bugs go in the reply as one line each ("`legacy_mode` is never read; left as is"), so the user decides.
- **Clean up only your own mess.** Remove imports, variables, or functions that your change made unused. Leave pre-existing dead code alone unless asked.
- **Don't improve the neighbors.** No refactoring, reformatting, or comment rewording next to your change.
- **Review your diff before you finish.** Every hunk should trace to the request. Revert any that don't.

**Not this:**
- Fixing an off-by-one in a loop and also renaming two variables, deleting a dead helper, and reformatting the file.

<!-- Adapted from section 3 "Surgical Changes" of the user's CLAUDE.md (0xKoios/skills, MIT, 0xKoios). Took: touch only what you must, match style, mention unrelated dead code without deleting it, clean up only your own orphans, the every-line-traces test. Changed: restated as a leaf with Why, Pattern and Not this, and added a mention-format example and a diff review step. -->
