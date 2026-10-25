# Refactoring

The structure changes and the behavior doesn't. When the cleanup turns up a bug or a missing feature, write it down, finish the structural change against the pin, then re-route the rest (see **Re-routing** in the router). A redesign that changes behavior is a Feature.

**Subagents:** Steps 1 and 2 can send fact lookups (callers, usages, existing tests) to read-only subagents. Step 4's mechanical edits go to a fresh subagent with a pointer brief: the file paths, the names being moved, and the pin command that must stay green. You review each diff and rerun the pin yourself. Steps 5 to 8 are yours.

1. Pin current behavior before any structure moves: a characterization test at a public seam, or the saved output of a run on a fixed input. Run it and show it passing. Type checks and lint aren't a pin, because they pass on code that does the wrong thing.
2. Name the target shape: the modules, types, and call graph you'd build today (`../../principle-foundational-thinking/SKILL.md`, `../../principle-model-the-domain/SKILL.md`). The shape deletes branches or invalid states rather than adding indirection.
3. Delete dead code, one-caller wrappers, and redundant checks first, in their own commit (`../../principle-subtract-before-you-add/SKILL.md`).
4. Move the structure in small steps, one commit each, rerunning the pin after every step. Migrate every caller and delete the old API in the same wave (`../../principle-migrate-callers-then-delete-legacy-apis/SKILL.md`). Grep each renamed name across code, strings, and docs, because renames miss usages there.
5. Rerun the pin and diff its output against step 1's. Any difference is a behavior change, so revert the step that caused it.
6. Check that the diff lowers reader load (`../../principle-minimize-reader-load/SKILL.md`). Revert a step that doesn't.
7. Order the commits as subtraction, reshape, then follow-on cleanup, each green on its own (`../../principle-sequence-verifiable-units/SKILL.md`).
8. Prove it works on the real output (`../../principle-prove-it-works/SKILL.md`).

**Reply:** the structure that changed, the pin and its before-and-after output, the reader-load change, and what got reverted. No new behavior.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/refactoring.md (cursor/plugins, MIT, Lauren Tan). Took: pin the behavior contract before any move, type checks are not a pin, name the missing structure and the target shape, subtract first, small pin-green steps, callers migrated with the old API deleted in one wave, the rename spot-check, the equivalence proof, the reader-load test, ordered commits, and the reply. Changed: dropped the how, design fan-out, and large-work skills, the control skill, and the pinned refactoring model; the pin is a test or a saved output diffed before and after; the playbook ends with Prove It Works; added the Subagents line. -->
