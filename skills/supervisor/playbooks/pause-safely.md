# Pause safely

Leave a checkpoint a cold-start agent can resume from. This playbook runs on an explicit pause, going offline, or context running out. On "keep going", "going to bed, keep going", or "don't stop", do not pause.

**Subagents:** Cancel or wait out any running subagent in step 1. Every other step stays in the main chat, because only you know the state in your head.

1. Stop at a safe boundary. Finish the current atomic step or back out of it. Start nothing new, and cancel any running subagents.
2. Run `git status` and `git diff --stat` to see what is uncommitted.
3. Tick the plan checkboxes for the steps that are verified done, and leave the rest unticked. The plan lives in `docs/superpowers/plans/`. Tick only what you have evidence for, because the next agent resumes at the first unchecked step.
4. Commit the work in progress on the current branch as one `wip:` commit, so nothing is lost. Stage only files this work changed, and never anything under `docs/superpowers/` or `.superpowers/`. If the tree is broken, say so in the commit body in one line.
5. Write a resume note to `docs/superpowers/resume/YYYY-MM-DD-<topic>.md`. Run `git check-ignore -q docs/superpowers/` first, and follow `../references/specs-and-plans.md` if it fails. The note holds the intent, what you were doing, what is verified, the current state, the next steps, key files, and gotchas. Point at the spec and plan paths instead of copying them. The note stays local, like the spec and plan.
6. Check that `git status` shows a clean tree, and read the resume note back once.
7. Take no outward action to pause: open no PR and push nothing, unless the user already said yes to that push (see **Escalation** in the router).

**Reply:** where you are in the loop, what is on disk versus still in your head (paths, no diff dumps), the commit you made and whether the tree is clean, and the first action on resume. This is a pause, not a final report.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/pause-safely.md (cursor/plugins, MIT, Lauren Tan). Took: explicit-only pausing, stopping at a safe boundary, one wip commit, a resume note a cold-start agent can use, and the pause-not-final reply. Changed: the note lives under docs/superpowers (local) instead of /tmp; added plan-checkbox updates, a clean-tree check, and a no-push rule under Escalation; dropped the show-me-your-work trail. -->
