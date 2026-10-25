---
name: supervisor-reflect
description: "Mines a finished or in-flight session for durable learnings and routes each one to a concrete edit on a skill the session used, through an approval gate. Invoked only as /supervisor-reflect. Runs three lens reviews, synthesizes Accepted, Rejected and Backlog lists, and edits nothing until the user approves."
disable-model-invocation: true
---

# Supervisor reflect

You turn one session into skill edits. A learning that stays in chat is lost, and a learning that lands in the wrong file never fires. Nothing is edited without the user's explicit yes, because skill changes affect every future run.

Skip the run when the session is trivial, off-topic, or already handled by a skill the agent followed correctly. One-offs are not learnings.

## Steps

1. **Read your harness adapter once**: `../supervisor/harness/claude-code.md`, `../supervisor/harness/copilot.md`, or `../supervisor/harness/cursor.md`. It maps "spawn a subagent" to a real tool and names where transcripts live.
2. **Find the transcript.**
   - If the user named a file or pasted a digest, use that.
   - Otherwise take the newest session file in this workspace's transcript folder from the adapter. Read only this workspace's folder, because other folders hold private chats from unrelated projects.
   - Check the first user message in the file matches this session's opening prompt. If nothing matches, write a tight digest of the session yourself and use that.
3. **List the skills the session used.** A skill counts as used when the transcript shows it read, a subagent brief naming its path, or a command it documents being run. Reviewers route only to these, because a routing to a skill nobody opened is a guess.
4. **Run the three lenses** on the same transcript. Each lens is a reference file:
   - Judgment: `references/judgment-lens.md`
   - Tooling: `references/tooling-lens.md`
   - Divergent: `references/divergent-lens.md`

   With a subagent tool, spawn all three in one message, so they run in parallel and their contexts stay out of yours. Give each a pointer brief: the lens file path, the transcript path, the used-skills list, and an output path for its findings. Use the harness default model. Without a subagent tool, read each lens file and run it yourself, one after another, writing each lens's findings to its own file.
5. **Synthesize.** Follow `references/synthesizer.md` with the three findings files. Use a subagent when you have one. Otherwise do it yourself. The result is three lists: Accepted, Rejected, Backlog.
6. **Check structure.** Move any Accepted row that a lint rule, script, metadata flag, or runtime check would enforce more reliably to Backlog (`../principle-encode-lessons-in-structure/SKILL.md`). Skill prose is for what mechanisms can't enforce.
7. **Present the lists and stop.** Show Accepted, Rejected and Backlog in full. For each Accepted row show the target skill file, the section, and the intended change. Ask the user which rows to apply. The user may drop rows or redirect a routing. Edit nothing yet.
8. **Apply each approved row** per `../supervisor/references/corrections.md`, starting at its step 3. That means:
   - Edit the file in the user's clone of `0xKoios/skills`, never only the installed copy.
   - Show the diff and a new eval case for that skill's `evals/evals.json`, and run the case.
   - Commit on a `correction/<skill>-<short-slug>` branch.
   - Never push. The user reviews and pushes.
9. **Route by size.**
   - A one-line bullet, a tightened sentence, or a corrected fact: edit directly.
   - A new section, a new table, or more than about 10 lines: follow `../supervisor/playbooks/authoring-a-skill.md`.
   - A skill that existed but didn't fire (`tune description`): edit its description and add a case whose prompt should trigger it.
   - A new skill: also `../supervisor/playbooks/authoring-a-skill.md`. Propose it in one line first.
10. **Run `bash scripts/check-skill.sh`** in the clone after the edits. Fix what it reports.

## Gates

- The Accepted list always waits for approval. A "just do it all" before you have shown the list is not approval of rows the user hasn't seen.
- Backlog items are listed in the reply only. There's no tracker. Each gets the pattern, what was hit, and the suggested mechanism.
- Escalation follows the router's Escalation section (`../supervisor/SKILL.md`). A lens that stalls after 3 rounds with no new evidence gets one rerun on the harness's strongest model, then goes to the user.

## Reply

Short lists, no preamble:

- Accepted: target file, section, one-line change. Awaiting approval.
- Rejected: one line each, with the reason.
- Backlog: pattern, what was hit, suggested mechanism.
- After approval: branch name, the branch it started from, and the eval line per edit.

<!-- Adapted from pstack/skills/reflect/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: the three parallel lenses plus synthesizer, the used-skills scope rule, the approval gate before any edit, the structural-enforcement check, and the Accepted/Rejected/Backlog summary. Changed: transcript lookup goes through the harness adapters, no pinned models or model rule file, sequential fallback without subagents, approved edits follow the corrections flow with an eval case each and no push, substantive edits route to the authoring-a-skill playbook, and Backlog is listed in the reply instead of filed to a tracker. -->
