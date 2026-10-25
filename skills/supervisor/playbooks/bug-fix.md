# Bug fix

A reported defect to reproduce, root-cause, and fix. There's no questioning phase, because the repro and the code hold the facts. Start work at once. A bug in a pipeline, model, or table runs from `data-change.md`, which uses this flow with its data repro methods.

Every shipped line traces to evidence. A change that "might help" is a hypothesis, not a fix, so it doesn't ship. Follow `../references/debugging.md` for each step below.

**Subagents:** Steps 1 to 4 can fan out: independent probes or repro attempts go to fresh subagents with pointer briefs (the symptom, the loop command, the hypothesis to test, the branch). Step 7 delegates the fix with the failing test as its success criterion. Step 8 stays in the main chat, because a backfill is the user's decision. You review every diff and rerun every result yourself.

1. Build a red-capable feedback loop and show its failing output. When the repro list runs out, escalate (see **Escalation** in the router).
2. Minimise the repro until removing any remaining piece turns the loop green.
3. Post 3 to 5 ranked one-line hypotheses, then keep working without waiting for a reply.
4. Probe one variable at a time on dev or sample data until one mechanism survives on runtime evidence.
5. List the callers, jobs, and consumers of the code you'll change, and how each is affected.
6. Turn the minimal repro into a failing test and commit it before the fix, so history shows it red without the fix.
7. Apply the smallest fix at the root cause (`../../principle-fix-root-causes/SKILL.md`), then watch the test and the original loop pass.
8. Ask the user whether data or state written while the bug was live needs a backfill, with the range and cost. Run none without a yes.
9. Remove the tagged debug logs and throwaway harnesses.
10. Prove it works on the real output (`../../principle-prove-it-works/SKILL.md`).
11. Run **Opening a PR**.

**Reply:** what was broken, the root cause (the confirmed hypothesis), the fix, and the failing-then-passing repro output pasted verbatim. Then the backfill question or its answer, and the principles that shaped the fix.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/bug-fix.md (cursor/plugins, MIT, Lauren Tan). Took: reproduce it yourself first, ruling hypotheses out on runtime evidence, the smallest change the evidence justifies, belt-and-braces as a hypothesis, verifying on the same surface, the failing repro committed before the fix, then Opening a PR, and the reply with verbatim repro output. Changed: replaced the control skill, how and why skills, /loop, the design fan-out skills, and pinned model lines with the steps in references/debugging.md; added no questioning, listing dependents before the fix, the backfill question after it, debug-log cleanup, Prove It Works, routing data bugs to data-change, and the Subagents line. -->
