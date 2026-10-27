# Eval

Test how a skill or prompt change affects agent behavior before keeping it. Use it for big changes: a new playbook or a rewritten skill. A small edit gets its cases from **Authoring a skill** and nothing more. You own the experiment design: plan, blind, run, synthesize.

A candidate that knows it is being watched behaves differently, so the run is blind. These rules hold in every step:

- Keep words that name the measurement out of every directory, file, and prompt a candidate sees: `eval`, `test`, `judge`, `experiment`, `rubric`, `score`, `compare`, `benchmark`, `candidate`.
- Write the candidate prompt as an organic user request. State the goal, not the meta.
- Don't ask the candidate to list which skills, principles, or files it used. Grade chain-following from the files it opened and the shape of its output.
- Name directories like a user's project, not like an experiment.
- Don't tell a candidate that other candidates exist.
- The judge sees outputs by sanitized label only, never a model name.
- When comparing two variants, one judge scores both sets in a single pass on one scale, blind to which set each came from.

**Subagents:** Candidates in step 5 and the judge in step 6 are fresh subagents with pointer briefs (a workspace path and the prompt file). Steps 1 to 4 and 7 to 9 stay in the main chat. Without a subagent tool, take the sequential path in step 5.

1. State the variant under test and what behavior counts as success.
2. Write a rubric of 3 to 6 concrete criteria for the judge only. Never put it where a candidate can read it.
3. Set up one sanitized workspace per candidate, with the variant installed. Plant the context an organic task would have, such as a project skeleton and the skills the agent would read.
4. Write one organic prompt, the way a user would type it, to a file only the main chat reads.
5. Run N candidates, 3 or more, on different models where the harness allows it. Give each its own workspace and the same prompt. Without subagents, run them one after another with `scripts/eval-skill.sh <skill> <agent> --trials N`, then again with `--baseline` so the variant has something to beat.
6. Run one blind judge on a different model than the candidates, where the harness allows it. Give it the rubric and the outputs by sanitized label. With no second model, state that the judge shares a model with the candidates, because that weakens the verdict.
7. Verify the chain from transcripts, not self-report. Read each candidate's transcript from this workspace's own transcript folder (see your harness adapter), never other projects'. Note which files each candidate actually opened.
8. Read every candidate's output end to end yourself. Compare it with the judge's verdict. A disagreement means the judge is biased or the rubric is ambiguous, so say which.
9. Recommend promoting the variant or not, with the evidence. A promotion changes a skill file, so it goes to the user as a diff (see **Corrections** in the router).

**Reply:** the variant under test, the rubric, per-candidate notes, the judge's verdict, your synthesis, and a recommendation on promoting the variant.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/eval.md (cursor/plugins, MIT, Lauren Tan). Took: the blinding rules, organic prompts, sanitized workspaces, N candidates, a blind judge on a different model, chain verification from transcripts, and reading every output yourself. Changed: dropped the arena skill phases and Cursor transcript paths; added the sequential path through scripts/eval-skill.sh with --baseline, the scope limit to big changes, and promotion as a user-approved diff. -->
