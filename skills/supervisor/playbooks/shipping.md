# Shipping

Verify each PR independently, land only the verified run from the root, then keep your hands off the stack. A merge is irreversible, so it goes to the user (see **Escalation** in the router). You prepare it, and the user says yes.

**Subagents:** Each PR's verifier in step 1 is a fresh subagent that did not write the code, with a pointer brief (the PR number, the base and head, how to run the change). Without a subagent tool, you verify it yourself and label the result `author-verified`. An `author-verified` result is not a `PASS`: it blocks that PR in step 5 until the user accepts it in step 4. Steps 2 to 18 stay in the main chat, because the merge decision belongs to the user.

**Outward rule.** Before every push, PR comment, and `gh pr edit`, show the user the exact content (the comment text, or the branch and commits being pushed) and wait for a yes. Every force push goes to the user too. Merges need their own yes (step 8).

1. Verify each PR independently. Check out the parent and the head and run the change the way a user would. Green CI and an approving review are not verdicts, because neither runs the change as a user would.
2. Write a verdict for each PR: `PASS`, `PASS+NOTES`, or `FAIL`. Only a verdict from an agent that did not write the code counts, because an author checks what it meant to build.
3. Show the user each verdict comment, then post it with `gh pr comment <number> --body-file <file>` on their yes.
4. List every PR whose result is `author-verified`. Show the user each one, one at a time, and ask whether to accept or reject it. An accepted result counts as `PASS+NOTES` for the walk below. A rejected one blocks its PR.
5. Walk up from the lowest unmerged PR and stop at the first one without `PASS` or `PASS+NOTES`, or with an `author-verified` result the user hasn't accepted. The PRs below it are the run, and the top one is the ceiling. A verified PR above a blocked one waits, because it can't land without the code below it.
6. Compare `git patch-id` at each verdict's SHA with the PR's current head, because a rebase moves a PR to a new SHA without failing any check. When the patches match, the verdict stands. When they differ, the change gets fresh checks and a fresh verdict, because the old verdict never saw it.
7. When the patches differ only in tests, docs, or lint config, keep the verdict only if what it ran builds the same at both SHAs, and report the differing files so the user can check the call.
8. Show the user the run, the ceiling, each PR's verdict and who produced it, and the exact merge command. Wait for an explicit yes. Silence is not a yes.
9. Don't arm `--auto` unless the verdict covers the PR's current head, because auto-merge lands whatever head is ready.
10. After the yes, merge the run's lowest unmerged PR with `gh pr merge <number> --squash`. Merge one PR at a time, bottom-up, because a PR whose base is still its parent's branch merges into that branch, not trunk.
11. Read the PR back with `gh pr view <number> --json state,mergedAt,baseRefName`. A landed PR reads merged. A merge command can report success when a merge queue only queued the PR, and a requested auto-merge is not a merge.
12. Show the user the retarget and the push, then on their yes run `gh pr edit <next> --base <trunk>` for the next PR.
13. Move the next PR's patch onto the merge result, then push it with `--force-with-lease` on the user's yes to that exact command.
14. Repeat steps 6 and 7 for it, because the move changes its head.
15. Repeat steps 8 to 14 for each PR up to the ceiling. Change nothing on the stack except steps 12 and 13, because a merge lands whatever its branch and base hold at that moment.
16. When a merge stalls, find out why with `gh pr checks` and `gh pr view` before you change anything.
17. Stop at the ceiling. Extending the run takes new verdicts, so it starts again at step 1.
18. Hand any deploy after the merge to the user (see **Escalation** in the router).

**Reply:** the verified run and its ceiling, each PR's verdict and who produced it, what landed and how you confirmed it, and what the next gap needs.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/shipping.md (cursor/plugins, MIT, Lauren Tan). Took: independent per-PR verification by a non-author, the contiguous verified run from the root, the patch-id re-check, bottom-up merges with a read-back, retargeting the child onto trunk, and stopping at the ceiling. Changed: dropped cloud-agent verifiers, the control skills, Origin, Graphite, the queued watcher, and the loop runner; verifiers are fresh subagents and a self-run check blocks until the user accepts it; every push, post, merge, and deploy waits for the user's yes under Escalation; split steps into single actions. -->
