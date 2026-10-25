# Session pickup

Resume a prior agent's in-flight work. You own the resume point. Read the prior trail and don't redo it, because a "verify from scratch" pass treats the trail as untrustworthy and repeats finished work.

**Subagents:** A long transcript in step 3 goes to a subagent that returns a reduced timeline, so the main chat doesn't carry the raw log (**principle-guard-the-context-window**). Every other step stays in the main chat. Without a subagent tool, read the transcript in slices yourself.

1. Locate the spec for the work in `docs/superpowers/specs/` and read its status block first. A gate line has the exact form `Gate: <questions done|spec approved|plan approved> YYYY-MM-DD`. List which gates are present and which are missing (see **Gates** in the router).
2. Find the branch and its state: `git branch --show-current`, `git status`, `git log <base>..HEAD --oneline`, and `git diff <base> --stat`. Read the latest resume note under `docs/superpowers/` if one exists, because **Pause safely** writes it for this step.
3. Read the plan in `docs/superpowers/plans/` and list its checked and unchecked steps.
4. Scan the prior transcript, if there is one, for decision points and the last messages. Use only this workspace's own transcript folder (see your harness adapter), because other projects' transcripts hold private chats from unrelated work.
5. Compare what shipped against what the plan says. Name the resume point: the first unpassed gate, or the first unchecked plan step. Don't re-run the prior repro or redo completed work. When a checkbox and the commits disagree, trust the commits and fix the checkbox.
6. State the resume point to the user in one line, with the gate or step it is. Ask only if two readings of the trail lead to materially different next steps.
7. Route the remaining work and open the matching playbook: continue the build, ship a finished result, ratify or override a prior conclusion, or write up a failed run. A missing gate means the first action is to ask for that approval, not to build. The routed playbook owns the rest.
8. Verify the inherited claims against the original goal on the real artifact (`../../principle-prove-it-works/SKILL.md`). A prior agent's passing self-report is not the proof.

**Reply:** where the prior agent stopped, what you inherited versus redid (ideally nothing redone), the gate or step you resumed at, and the outcome.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/session-pickup.md (cursor/plugins, MIT, Lauren Tan). Took: read the prior trail as authoritative, reconstruct the branch state, diff done against pending, name the resume point, parse long transcripts in a subagent, and verify inherited claims on the real artifact. Changed: resume reads the spec's gate lines first, then the branch and plan checkboxes; dropped cloud-agent URLs, Cursor transcript paths, and reasoning-level picks; added checkbox repair and a resume-note read. -->
