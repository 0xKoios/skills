# Multi-phase plan

Work that spans several phases or stacked PRs. The whole program passes Feature's three gates, and each phase passes its own set before its build. Each phase ends verified before the next starts, because later phases build on its result.

**Subagents:** Steps 1 to 8 stay in the main chat, because questions, approvals, and gates belong to the user's window. Fact lookups and the builder checks go to subagents. Step 9 delegates the phase's plan tasks, one fresh subagent per task, with a pointer brief: the program spec, the phase spec, the plan path, the task number, and the branch. You run step 10's verification yourself.

1. Question the user per `../references/questioning.md` about the whole program, then write `Gate: questions done YYYY-MM-DD` on the user's yes.
2. Write the program spec per `../references/specs-and-plans.md`, naming the phases in order with each one's goal and the evidence that proves it (`../../principle-outcome-oriented-execution/SKILL.md`). Write `Gate: spec approved YYYY-MM-DD` on the user's yes.
3. Write the program plan: the phases in order, their dependencies, and one PR per phase (`../../principle-sequence-verifiable-units/SKILL.md`). Write `Gate: plan approved YYYY-MM-DD` on the user's yes.
4. Read the program spec's status block and confirm all three gates are there (see **Gates** in the router).
5. For the next phase, question the user about what earlier phases changed, then write `Gate: questions done YYYY-MM-DD` on the user's yes in a new phase spec with `<topic>-phase-<n>` as its topic and its own status block.
6. Write the phase spec per `../references/specs-and-plans.md`, and write `Gate: spec approved YYYY-MM-DD` in its status block on the user's yes.
7. Write the phase plan, and write `Gate: plan approved YYYY-MM-DD` in the phase spec's status block on the user's yes.
8. Read the phase spec's status block and confirm all three gates are there. Refuse to build past a missing one.
9. Build the phase's tasks test-first per `../references/tdd.md`.
10. Verify the phase on its real output, and record the evidence in the phase spec. An unverified phase blocks the next one.
11. Run **Opening a PR** for the phase, stacked on the previous phase's branch.
12. Check the program plan against what the phase showed. When the plan is wrong, stop and escalate before the next phase (see **Escalation** in the router), because the approved plan no longer describes the work.
13. Repeat steps 5 to 12 for each remaining phase.
14. Prove it works on the real output (`../../principle-prove-it-works/SKILL.md`).

**Reply:** the current phase and its gate lines, each finished phase with its evidence and PR link, what stays unproven, and the next decision for the user.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/multi-phase-plan.md (cursor/plugins, MIT, Lauren Tan). Took: the plan as an evidence-checked checklist, one PR per phase with its own evidence, dependency order, tests alone are not verification, and execution only on the user's explicit go. Changed: dropped the plan-only scope, the skeleton template, the plan check script, the custom agent type, the parallel live-lane skill, the control skills, the audit loop, review-bot triage, and pinned model lines; added Feature's three gates for the program plus one gate set per phase in its own phase spec, each phase verified before the next, test-first builds, Prove It Works at the end, and the Subagents line. -->
