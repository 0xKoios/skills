# Specs and plans

A spec says what to build and why. A plan says how, as tasks a builder who has never seen the repo can run. Both stay local to the machine.

## Location

- Spec: `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
- Plan: `docs/superpowers/plans/YYYY-MM-DD-<topic>.md`

These paths are in the repo being worked on. Before writing either file, run `git check-ignore -q docs/superpowers/`. If it fails, append `docs/superpowers/` to `.git/info/exclude`. That file is local, so ignoring the docs changes nothing for other people. Never edit **.gitignore**, because it's shared and the change would land in someone's review. Never commit or `git add` these docs, because the user keeps specs and plans out of GitHub.

## Status block

The spec opens with a status block. Gate lines go there, one per line, in this exact format:

```text
Gate: questions done 2026-10-24
Gate: spec approved 2026-10-24
Gate: plan approved 2026-10-25
```

Write a gate line only after the user's explicit yes for that gate. Playbooks read this block before any build step and refuse to build past a missing gate, so a gate written early lets unapproved work through.

## Spec sections

Write for a capable builder in the domain who can't ask the user anything.

1. **Intent and the why.** The why lets the builder make unmentioned decisions the way the user would.
2. **Goals.**
3. **Non-goals.** What's out of scope.
4. **Anti-goals.** What would be a failure even if it technically works.
5. **Constraints.** Versions, platforms, limits, naming rules, with exact values.
6. **Decided by the user.** Each decision as the user made it, in their terms.
7. **Builder's calls.** Choices you made yourself, marked as yours so the user can check them.
8. **Left to the builder.** What the plan may decide.

Only what the user said goes under "Decided by the user". Your guesses go under "Builder's calls", because a guess filed as a decision can't be found and rejected.

## Builder check

Run it once the spec is written, before handing it to the user.

1. **Spawn a fresh subagent** with a pointer brief: "You're a [domain] engineer asked to plan the build in `<spec path>`. You can't talk to its author. List only the questions you'd need answered before you could plan it well, where a wrong guess would matter. For each, say why the answer changes the plan. Rank them. Skip what the spec leaves to the builder, what you could decide yourself, and wording nitpicks. If nothing important is left, say so."
2. **Without a subagent tool,** reread the spec as that builder would, with the same instructions.
3. **Sort each question:**
   - **Answered:** the conversation or the repo already answers it. Put the answer in the spec.
   - **Minor:** a sensible builder could settle it without changing what gets built. Settle it and add it to "Builder's calls".
   - **The user's:** only the user can answer it, and the answer changes what gets built.
4. **Ask the user's questions in one message,** most important first. This is the one exception to one question per message, because the check runs once and a batch keeps it to one round.
5. Update the spec with the answers.

## Spec approval

Send the spec path and a short list of the builder's calls, so the user checks those while reading. Don't summarize the spec, because the user reads the file. On an explicit yes, write `Gate: spec approved YYYY-MM-DD`.

## Plan format

Write for an implementer who knows the language but not this repo or spec. They can't know what you decided: which files, names, signatures, values, and tests. The plan records those decisions and nothing more.

**Header:**

- **Goal:** one sentence.
- **Architecture:** 2 or 3 sentences.
- **Spec:** the spec path. Implementers read both files.
- **Global Constraints:** the spec's project-wide rules, one line each, with exact values copied verbatim. Every task implicitly includes them.
- **Review Focus:** up to five inputs or failure modes the spec implies but no task's tests exercise, most likely first. Add a test for each to the task that owns the code.

**Each task:**

- **Files:** exact paths to create, modify, and test.
- **Interfaces:** what it consumes from earlier tasks and produces for later ones, with exact names and types. An implementer sees only their own task, so this block is how names stay consistent.
- **Test-first steps,** each one action with a checkable result:
  1. Write the failing test, with its name and assertions and the spec's exact values.
  2. Run it and see it fail. Give the command and the expected failure.
  3. Implement, giving the exact signature and file. Write a body only for an algorithm the signature and test don't determine.
  4. Run it and see it pass.
- **Commit:** the exact `git add` paths and message.

A task is the smallest unit with its own test cycle that a reviewer could reject while approving its neighbor. Fold setup and docs into the task that needs them.

## Plan self-review

Check the plan against the spec before handing it over. Fix what you find inline.

- **Coverage:** every spec requirement maps to a task. Add a task for any that doesn't.
- **Step scan:** a step that decides nothing ("handle edge cases", "TBD") is a gap. A step that writes out a body the signature and test already fix is a transcript. Fix both.
- **Consistency:** names and types in later tasks match the Interfaces blocks of earlier ones.
- **Proportion:** a plan several times longer than its spec has written the code instead. Replace bodies with signatures and assertions.

## Plan approval

Send the plan path and ask whether it captures what the user wants. On an explicit yes, write `Gate: plan approved YYYY-MM-DD` in the spec's status block. Build starts only after that line exists.

<!-- Adapted from skills/brainstorming/SKILL.md, skills/brainstorming/builder-check-prompt.md and skills/writing-plans/SKILL.md (obra/superpowers, MIT, Jesse Vincent). Took: the written design's sections, the fresh-subagent builder check with its prompt and answered/minor/theirs sort, the single round of the user's questions, the plan header with Global Constraints and Review Focus, the task block with Files, Interfaces and test-first steps, task right-sizing, and the plan self-review. Changed: docs go in a locally ignored path and are never committed (both "commit the doc" steps dropped), added .git/info/exclude handling, added the status block and gate lines, split decided-by-the-user from builder's calls, dropped playback chunks, the section walkthrough, the sizing table, the visual companion, and the execution-method handoff and sub-skill lines. -->
