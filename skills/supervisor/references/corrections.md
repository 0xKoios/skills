# Corrections

When the user corrects you ("no, don't do that", "that's wrong, we always..."), turn the correction into a proposed edit to the file that caused it. The next run then gets it right without the user repeating it. Nothing is edited without the user's explicit yes.

## Steps

1. **Stop mid-step.** Don't finish the step you're on, because it may repeat the mistake.
2. **Name the file that caused the mistake.**
   - A skill file (the router, a playbook, a reference, a principle leaf) when its instructions led you there.
   - The work repo's **AGENTS.md** when the correction is a fact about that project, such as a naming rule or a table owner.
3. **Find the clone.** Approved edits go in the user's clone of `0xKoios/skills`, never only in the installed copy, because the next install overwrites the installed copy.
   1. Run `realpath` on the installed skill file.
   2. If the result is inside a git repo whose remote matches `0xKoios/skills` (check `git -C <dir> remote -v`), use that repo's top level (`git -C <dir> rev-parse --show-toplevel`).
   3. Otherwise read the `clone:` line from `~/.config/supervisor/config.md`.
   4. If that file is missing, ask the user once for the clone's absolute path. Write the file with the single line `clone: <absolute path>`, so you never ask again.
4. **Show the proposal** in one message:
   - the file path in the clone;
   - a unified diff of the edit;
   - a new eval case for that skill's `evals/evals.json`, with the real prompt that led to the mistake and the expected behavior. See `eval-cases.md` for the format. If the skill has no evals.json yet, propose creating it.

   For an **AGENTS.md** edit, show the path and diff only. Project facts have no eval suite, so list the case and the eval run as `skip: project fact, no eval suite`.
5. **Wait for an explicit yes.** Silence, "hmm", or a new question isn't a yes. Keep working on the original task meanwhile only if it doesn't depend on the correction.
6. **Apply and run the case.** Apply the edit and the case in the clone. Run there, with your harness as `<agent>` (claude, cursor, or copilot):

   ```bash
   scripts/eval-skill.sh <skill> <agent> --case <id> --trials 3
   ```

   Show the PASS or FAIL line. If it fails, show why, revise the edit, and return to step 4, because a committed edit whose case fails hasn't fixed the mistake. If the runner can't start (exit 2, for example the agent CLI is missing), say so in one line and commit only on the user's yes.
7. **Commit on a branch.** In the clone, run `git switch -c correction/<skill>-<short-slug>`. Stage only the skill file and evals.json by path, because the clone may hold the user's other uncommitted work. Commit the edit and the case together, so the case always travels with the rule it tests. For an **AGENTS.md** edit, do the same in the work repo, as `correction/agents-<short-slug>`.
8. **Never push.** Tell the user the branch name and the branch it started from. They review and push.

Then return to the step you stopped at, applying the correction.
