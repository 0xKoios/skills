# Authoring a skill

Write or edit a skill file. You own the skill's voice. A skill is read by an agent mid-task, so every sentence must change a decision.

**Subagents:** Writing and editing stay in the main chat, because the voice must stay consistent. Running the cases in step 14 can go to a fresh subagent with a pointer brief (the skill path and the case ids). Without a subagent tool, run them yourself.

1. Read the skill's folder in full, or the nearest sibling skill when the skill is new, and match its format. Look before you write (`../../principle-look-before-you-write/SKILL.md`).
2. If the skill belongs to this stack (`0xKoios/skills`), find the clone (`../references/corrections.md` step 3). Work there, because the next install overwrites the installed copy.
3. Draft the skill or the edit without writing it yet. Frontmatter needs `name` equal to the folder name (lowercase, digits, hyphens, at most 64 characters) and a `description` of at most 1024 characters.
4. Set `disable-model-invocation: true` in the frontmatter of every skill in this stack, because they run only when invoked by name.
5. Use short declarative sentences and put each reason next to its rule. Delete any sentence that doesn't change a decision. Skip recaps. Match the tone to the scope: a leaf rule is terse, and a playbook is a list of steps.
6. Point at structural sources (types, READMEs, config) instead of restating them (`../../principle-encode-lessons-in-structure/SKILL.md`). Refer to other skills by path and don't paste their text. A backticked `*.md` token must name a file that exists relative to the file that mentions it.
7. Make no skill tell the agent to invoke, read, or install a skill that ships outside this repo.
8. Rewrite borrowed text in your own words and end the file with one provenance comment: `<!-- Adapted from <source path> (<repo>, MIT, <copyright holder>). Took: <what>. Changed: <what>. -->`. Confirm the holder from the source's LICENSE file.
9. Draft cases for `skills/<skill>/evals/evals.json` per `../references/eval-cases.md`. Every new or edited skill ships cases. Write each from a realistic prompt with no testing words, and cover the behavior the edit adds or changes.
10. Show the user the draft (the new file, or the diff) with its cases, and wait for an explicit yes. Write nothing before it, because a skill change affects every future run.
11. Write the files on a non-trunk branch. For a stack skill, write them in a temporary worktree off the clone's base branch (`../references/corrections.md` step 6), so the clone's current branch stays untouched.
12. Run `bash scripts/check-skill.sh`.
13. Fix everything it reports and rerun until it exits 0.
14. Run the new cases with `scripts/eval-skill.sh <skill> <agent> --case <id> --trials 3`, using your harness as `<agent>`.
15. Rerun them with `--baseline`. A case that still passes without the skill isn't tested by it, so propose retiring it in one line and let the user decide.
16. For a new playbook or a rewritten skill, run **Eval**.
17. If steps 13 to 16 changed the draft, show the new diff and wait for an explicit yes again.
18. Commit on the branch and show the user the branch and commits.
19. For a stack skill, never push: remove the worktree and leave the push to the user. For any other skill, push on the user's yes, then run **Opening a PR** if the work is meant for one.

When in doubt, delete. A workflow you keep repeating that no skill captures is a candidate for a new skill: propose it in one line.

**Reply:** what the skill does, the design choices and why, the check-skill output, the case results, and any case you propose to retire.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/authoring-a-skill.md (cursor/plugins, MIT, Lauren Tan). Took: owning the skill's voice, validating frontmatter and links, delete-when-in-doubt, pointing at structural sources, and delegating to other skills by path. Changed: dropped the built-in create-skill skill and its principle-skill wording; every skill now ships evals/evals.json cases and passes check-skill, borrowed files carry a provenance comment, and the work goes to the user before commit. -->
