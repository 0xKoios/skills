---
name: supervisor-correct
description: "Finds the mistakes agents keep repeating in a work repo and makes each one impossible. Fixes at the highest level that works: architecture, then types, then lint, then a test, with docs last. Proves each new check fails on a real past mistake. Invoked only as /supervisor-correct. Shows the class and the exact diff and waits for a yes before changing the repo."
disable-model-invocation: true
---

# Supervisor correct

You harden a work repo so the next agent can't repeat a mistake. A rule in a doc gets skipped under pressure, and a check that fails can't be. So enforce at the highest level that works.

Assume every contributor is an agent that sees only the files it opened, copies the nearest example, and takes the shortest path that compiles. Design the repo so a change that looks right from one file is right for the whole repo.

## Levels

Try them in this order. Stop at the first that works.

1. **Architecture.** Give each piece of state one owner and each task one supported way. Hide internals so the wrong import fails. Replace hand-synced lists with one source of truth. Delete old ways and dead code an agent would copy.
2. **Types.** Make the bad state impossible to write. Use types when the bad code would otherwise compile.
3. **Lint.** Use a rule when bad code still compiles. The error names the file, type, or function to use instead, because the agent reads the error and nothing else. If the pattern is already common, fail only when a change adds more, so the rule can ship before the cleanup.
4. **Test.** Test the behavior. Fix or delete any test that still passes when the behavior it checks breaks, or that fails when only the internals change.
5. **Docs.** Write a doc or agent rule last, and only for judgment calls. Nothing fails when an agent skips it.

## Steps

1. **Find the mistake classes.** Read recent commits, reverts, review comments (a file the user named comes first), the agent instruction files, and comments that explain workarounds. Group the mistakes into classes. A class counts once it has happened twice. Count the occurrences and note where each happened.
2. **Pick a level per class.** Start at architecture and move down only when the higher level doesn't work here. Write one sentence on why each higher level failed, because that sentence is the check against lazy docs.
3. **Propose and stop.** Show, per class: the evidence, the level, why a higher level doesn't work, and the real past mistake the check will be proven against. Ask which classes to take, most frequent first. Selecting a class only chooses it for proposal and never authorizes an edit, because the user hasn't seen the diff. Change nothing yet.
4. **Show the exact diff** for one selected class: every file to add or edit, including the rule-table row in the work repo's agent-instructions file: **AGENTS.md**, or the one your harness adapter names. Say how you'll prove the check fails. Then wait for an explicit yes on that diff. Silence, "hmm", or a new question isn't a yes.
5. **Get on a non-trunk branch in the work repo.** If you're on the trunk, run `git switch -c correct/<short-slug>`. Do this before any edit, so the approved change never lands on the trunk.
6. **Apply it.** Edit the repo, and only what the shown diff contains. If the change needs to grow, return to step 4.
7. **Prove the check fails on a real past mistake.** Replay the mistake in a separate worktree, so your approved edit stays untouched: run `git worktree add <temp-path> <old-commit>`, or re-create the flagged code there. Run the check in it. It must fail with an error that names the fix. Remove the worktree with `git worktree remove <temp-path>`. Then run the check on the corrected code and see it pass. If it passes on the mistake, go back to step 2, because a check that never failed proves nothing.
8. **Commit on the branch.** Stage files by path, because the repo may hold the user's other uncommitted work. Make one commit per class, with the check and its rule-table row together.
9. **Show the branch and commits.** Give the branch name, the branch it started from, and the commit list.
10. **Never push.** The user reviews and pushes.
11. **Repeat from step 4** for the next selected class.

## The rule table

Keep a table in the work repo's agent-instructions file (**AGENTS.md**, or the one your harness adapter names) that pairs each rule with what enforces it. Add the row in the same commit as its check.

- When the user corrects you mid-task, fix the mistake and add the rule through `../supervisor/references/corrections.md`, which has the same approval and branch rules.
- If the rule was already there and nothing enforces it, that's a repeat. Fix it at the highest level that works, in the same change.
- Drop a rule once its mistake can't happen.

## Exceptions

An exception goes on the offending line, with a reason. The rule rejects a bare disable comment, because an unexplained exception can't be reviewed later.

## Gates

- No edit to the work repo before the user has seen the exact diff and said yes. Approving a class never counts.
- Never commit on the trunk. Never push.
- A check you couldn't prove against a real past mistake isn't committed. Say so and ask.

## Reply

- Per class: evidence (count and places), the level, and why a higher level didn't work.
- Before approval: the diff, awaiting a yes.
- After: branch, starting branch, commits, and the proof output for each check.

<!-- Adapted from pstack/skills/correct/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: the levels ladder, the two-occurrence rule for a class, "prove each check fails on a real past mistake", and the rule table paired with its enforcement. Changed: added the propose, show-diff and explicit-yes gates before any edit, commits go on a non-trunk branch in the work repo and the user pushes, the rule table lives in AGENTS.md, and the CI and exception-approval parts were dropped, keeping an exception on the offending line with a reason. -->
