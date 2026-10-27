# Corrections

When the user corrects you ("no, don't do that", "that's wrong, we always..."), turn the correction into a proposed edit to the file that caused it. The next run then gets it right without the user repeating it. Nothing is edited without the user's explicit yes.

## Steps

1. **Stop mid-step.** Don't finish the step you're on, because it may repeat the mistake.
2. **Name the file that caused the mistake.**
   - A skill file (the router, a playbook, a reference, a principle leaf) when its instructions led you there.
   - The work repo's agent-instructions file: **AGENTS.md**, or the one your harness adapter names. Use it when the correction is a fact about that project, such as a naming rule or a table owner.

   To choose, ask whether the rule would hold in any repo. If it would, it's a skill correction. If it's a convention or fact true only of this repo, it goes in the agent-instructions file. When unsure, the proposal says which one you chose and why, so the user can redirect it.
3. **Find the clone (skill-file corrections only).** An approved skill edit goes in the user's clone of `0xKoios/skills`, never only in the installed copy, because the next install overwrites the installed copy. For an agent-instructions correction, skip this step: the file shown and edited is the work repo's.
   1. Run `realpath` on the installed skill file.
   2. If the result is inside a git repo whose remote matches `0xKoios/skills` (check `git -C <dir> remote -v`), use that repo's top level (`git -C <dir> rev-parse --show-toplevel`).
   3. Otherwise read the `clone:` line from `~/.config/supervisor/config.md`.
   4. If that file is missing, ask the user once for the clone's absolute path. Write the file with the single line `clone: <absolute path>`, so you never ask again.
4. **Show the proposal** in one message:
   - the file path: in the clone for a skill file, in the work repo for the agent-instructions file;
   - a unified diff of the edit;
   - a new eval case for that skill's `evals/evals.json`, with the real prompt that led to the mistake and the expected behavior. See `eval-cases.md` for the format. If the skill has no evals.json yet, propose creating it.

   For an edit to the work repo's agent-instructions file (**AGENTS.md**, or the one your harness adapter names), show the work repo's path and the diff only. Project facts have no eval suite, so list the case and the eval run as `skip: project fact, no eval suite`.
5. **Wait for an explicit yes.** Silence, "hmm", or a new question isn't a yes. Keep working on the original task meanwhile only if it doesn't depend on the correction.
6. **Make a temporary worktree.** Never switch the target repo's current branch, because it may hold the in-flight task. The target repo is the clone for a skill file and the work repo for the agent-instructions file. Run `git -C <repo> worktree add -b <branch> <temp-path> <base>`, where `<base>` is the repo's base branch, such as `main`. Name the branch `correction/<skill>-<short-slug>`, or `correction/agents-<short-slug>` for the agent-instructions file.
7. **Apply and run the case in the worktree.** Apply a skill edit and its case there. Apply an agent-instructions edit there and skip the run. For a skill edit, run this in the worktree, with your harness as `<agent>` (claude, cursor, or copilot):

   ```bash
   scripts/eval-skill.sh <skill> <agent> --case <id> --trials 3
   ```

   Show the PASS or FAIL line. If it fails on content, show why, revise the edit, and return to step 4, because a committed edit whose case fails hasn't fixed the mistake. A FAIL whose reason is `[agent run failed]`, or an exit 2 (for example the agent CLI is missing), is infra, not content. Say so in one line, don't revise the edit, and commit only on the user's yes.
8. **Commit in the worktree.** Stage only the edited file and evals.json by path. Commit the edit and the case together, so the case always travels with the rule it tests.
9. **Remove the worktree** with `git -C <repo> worktree remove <temp-path>`. The branch stays.
10. **Never push.** Tell the user the branch name and the base it started from. They review and push.

Then return to the step you stopped at, applying the correction.
