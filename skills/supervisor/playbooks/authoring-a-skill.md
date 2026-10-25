# Authoring a skill

Write or edit a skill file. You own the skill's voice. A skill is read by an agent mid-task, so every sentence must change a decision.

**Subagents:** Writing and editing stay in the main chat, because the voice must stay consistent. Running the cases in step 8 can go to a fresh subagent with a pointer brief (the skill path and the case ids). Without a subagent tool, run them yourself.

1. Read the skill's folder in full, or the nearest sibling skill when the skill is new, and match its format. Look before you write (`../../principle-look-before-you-write/SKILL.md`).
2. Write or edit the skill. Frontmatter needs `name` equal to the folder name (lowercase, digits, hyphens, at most 64 characters) and a `description` of at most 1024 characters. Add `disable-model-invocation: true` where the skill must only run when invoked by name.
3. Use short declarative sentences and put each reason next to its rule. Delete any sentence that doesn't change a decision. Skip recaps. Match the tone to the scope: a leaf rule is terse, and a playbook is a list of steps.
4. Point at structural sources (types, READMEs, config) instead of restating them (`../../principle-encode-lessons-in-structure/SKILL.md`). Refer to other skills by path and don't paste their text. A backticked `*.md` token must name a file that exists relative to the file that mentions it.
5. Make no skill tell the agent to invoke, read, or install a skill that ships outside this repo. Rewrite borrowed text in your own words and end the file with one provenance comment: `<!-- Adapted from <source path> (<repo>, MIT, <copyright holder>). Took: <what>. Changed: <what>. -->`. Confirm the holder from the source's LICENSE file.
6. Add or update cases in `skills/<skill>/evals/evals.json` per `../references/eval-cases.md`. Every new or edited skill ships cases. Write each from a realistic prompt with no testing words, and cover the behavior the edit adds or changes.
7. Run `bash scripts/check-skill.sh` and fix everything it reports until it exits 0.
8. Run the new cases with `scripts/eval-skill.sh <skill> <agent> --case <id> --trials 3`, using your harness as `<agent>`. For a new playbook or a rewritten skill, also run **Eval**. A case that still passes with `--baseline` isn't tested by the skill, so propose retiring it in one line and let the user decide.
9. Show the user the diff. Wait for an explicit yes before committing, then run **Opening a PR** if the work is meant for one.

When in doubt, delete. A workflow you keep repeating that no skill captures is a candidate for a new skill: propose it in one line.

**Reply:** what the skill does, the design choices and why, the check-skill output, the case results, and any case you propose to retire.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/authoring-a-skill.md (cursor/plugins, MIT, Lauren Tan). Took: owning the skill's voice, validating frontmatter and links, delete-when-in-doubt, pointing at structural sources, and delegating to other skills by path. Changed: dropped the built-in create-skill skill and its principle-skill wording; every skill now ships evals/evals.json cases and passes check-skill, borrowed files carry a provenance comment, and the work goes to the user before commit. -->
