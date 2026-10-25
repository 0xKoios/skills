# Feature

New or changed behavior. Questions and gates come first, because what you'd build from the request alone is a guess about what the user wants.

**Subagents:** Steps 1 to 5 stay in the main chat, because questions, approvals, and gates belong to the user's window. Fact lookups during step 1 and the builder check in step 2 go to subagents. Step 7 delegates each plan task to a fresh subagent with a pointer brief: the spec path, the plan path, the task number, and the branch. You review each diff before the next task starts. Steps 8 and 9 are yours.

1. Question the user per `../references/questioning.md` until its stop rule, then write `Gate: questions done YYYY-MM-DD` on the user's yes.
2. Write the spec per `../references/specs-and-plans.md`, run its builder check, and write `Gate: spec approved YYYY-MM-DD` on the user's yes.
3. Choose the core types and data shape before planning, because the plan's tasks build on them (`../../principle-foundational-thinking/SKILL.md`, `../../principle-model-the-domain/SKILL.md`).
4. Write the plan per `../references/specs-and-plans.md`, and write `Gate: plan approved YYYY-MM-DD` on the user's yes.
5. Read the spec's status block and confirm all three gates are there (see **Gates** in the router). Refuse to build past a missing one.
6. Split tasks that would write the same files or state into separate targets before delegating, because parallel writers to one target collide (`../../principle-separate-before-serializing-shared-state/SKILL.md`).
7. Build the plan's tasks test-first per `../references/tdd.md`, one task per fresh subagent, committing each verified task before the next (`../../principle-sequence-verifiable-units/SKILL.md`).
8. Check the build against the approved spec. When it outgrows the spec, stop and escalate (see **Escalation** in the router), because the user approved a smaller scope.
9. Prove it works on the real output (`../../principle-prove-it-works/SKILL.md`).
10. Run **Opening a PR**.

**Reply:** what you built, what you chose and why with the principles cited, the gate lines, the proof output, and open decisions.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/feature.md (cursor/plugins, MIT, Lauren Tan). Took: owning the design while delegating implementation, scoped briefs that name the data shape before code, splitting shared state rather than serializing, verifying on the real surface, small ordered commits, then Opening a PR, and the reply's choices and open decisions. Changed: replaced the how and design fan-out skills, the throughput checkpoint, the competing-runner skill, the contested-design review skill, and pinned model lines with questioning, spec, plan, and three hard gates; the build is test-first through pointer briefs; added Prove It Works and the Subagents line. -->
