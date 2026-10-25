# Prototype

A throwaway sketch that settles a design or behavior question by observing it instead of asking. It has no gates and no planning, because the code is an instrument, not a product. Speed beats polish here. The rigor goes into picking the right design cheaply: try variations the user didn't ask for, and throw an approach away to try another.

**Subagents:** Step 3 can build and run variants in parallel, one fresh subagent per variant, each briefed with the decision, the variant to build, and the scratch path. Steps 1, 5, and 6 stay in the main chat, because the decision and what it taught belong to the conversation.

1. Name the one decision the prototype settles, in one line. With no decision to settle, re-route to **Feature** (see **Re-routing** in the router).
2. Build in a scratch directory outside the production source, with the lightest stack that shows the idea. Write no tests, or one smoke check when the question is about output, and no abstractions.
3. To compare options, build each as a labeled variant behind one switch, such as a flag or an argument (`../../principle-exhaust-the-design-space/SKILL.md`).
4. Run each variant and record what you see: the output, the timing, or a screenshot. The observation is the test.
5. Write what it taught back into the conversation: the variants, the evidence, the tradeoffs, and your recommendation.
6. Leave the prototype out of the production branch. Keeping its output is a new task that goes through **Feature**, with its questions and gates, because the prototype skipped both.

**Reply:** the decision, the variants, the evidence for each, the tradeoffs, your recommendation, and the scratch path. Say plainly that the prototype is throwaway.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/prototype.md (cursor/plugins, MIT, Lauren Tan). Took: the prototype as a throwaway instrument for a decision, no decision means Feature, speed over polish, a scratch dir apart from production source, labeled variants behind one switch, observation as the test, and handing the chosen direction to Feature. Changed: dropped the control skill, the moodboard step, and the design fan-out skill; added no gates, what it teaches goes back into the conversation, keeping the output is a new Feature task, and the Subagents line. -->
