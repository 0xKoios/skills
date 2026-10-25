# Questioning

Feature and multi-phase tasks start here. Bug fixes and investigations skip it and go straight to work.

You build what you believe the user wants, and that belief is usually thinner than it feels. Questioning finds out what they want and why, so the decisions they never mention get made the way they would make them.

## Rules for every message

- **One question per message, as a single sentence.** A list of questions gets the easy one answered and the hard ones skipped.
- **Look up facts yourself.** Never ask what a file, command, search, or subagent can answer. Facts are your job and decisions are the user's. A lookup still running blocks only the questions that depend on it, so ask another question meanwhile.
- **No recap or playback.** Don't summarize what the user said or describe the shared understanding back. The user reads every word, and a recap costs their time without adding a decision.
- **Confirmations are 1 or 2 lines.** "Got it, Parquet on S3." is enough.
- **Plain words.** Match the user's vocabulary and skip process jargon, because jargon makes the user translate before they can answer.
- **Defaults said out loud.** When you pick something yourself, say it in one line and record it in the spec as a builder's call. A default the user never heard is one they couldn't reject.

## Pick one mode

Pick the mode at the start, from what the user brought. Never run both modes on one task, because switching re-asks ground that's already settled.

- **Brainstorm mode:** the idea is fuzzy. There's a goal or a problem, but no written plan or design.
- **Grill mode:** a plan exists. The user brought a plan, spec, design, or a concrete proposal to stress-test.

### Brainstorm mode

1. **Open questions first.** Ask about a real moment or a concrete picture: "What happened the last time you wished this existed?" The user's own words carry intent that your options can't.
2. **Then guesses they can correct.** Once you have some grounding, a guess beats a question: "I'm guessing the nightly job is too slow to rerun by hand?" It's faster to fix a wrong guess than to answer from scratch.
3. **Menus only when stuck.** Offer 2 or 3 options only when the user can't describe it. Options steer the answer toward what you thought of.
4. **"Just guess" gets a concrete proposal**, not another question.

Ground to cover. This is territory, never a script to read out:

- what the thing is, and what success looks like to them
- why now
- goals, non-goals, and anti-goals (what would be a failure even if it technically works)
- the current state: what exists, what they've tried
- prior art they liked or hated
- which build choices they want to make (language, tools, platform) and which they hand to you

Before you propose anything, think of several approaches privately and drop the weak ones. Show a comparison only when it helps the user decide.

### Grill mode

1. **Map the plan as a decision tree.** Each decision branches into the decisions that depend on it.
2. **Resolve dependencies one at a time.** Ask about a decision only once everything it depends on is settled, because an answer built on an open question gets asked again later.
3. **Lead with the decision that unblocks the most.** Settling it moves the most branches forward.
4. **Carry your recommendation in the question.** Word it so "yes" accepts it: "Should reruns overwrite the partition, since downstream jobs read only the latest?"
5. **Attack weak branches.** When a decision rests on an untested premise, ask about the premise (`../../principle-attack-the-premise/SKILL.md`).

## When to stop

Stop when the spec could be written without guessing: every branch is visited and nothing that changes what gets built is silently assumed.

1. Ask one line: "Ready for me to write the spec?" A yes means proceed. Anything else means more questions.
2. On the user's yes, create the spec file and write `Gate: questions done YYYY-MM-DD` in its status block, with today's date. See `specs-and-plans.md` for the location and status block.

<!-- Adapted from skills/productivity/grilling/SKILL.md (mattpocock/skills, MIT, Matt Pocock) and skills/brainstorming/SKILL.md (obra/superpowers, MIT, Jesse Vincent). Took: grilling's decision tree, settled-prerequisites ordering, "yes accepts the recommendation" wording, and facts-are-yours rule; brainstorming's open questions first, guesses the user can correct, menus only when stuck, ground to cover, defaults said out loud, and thinking wide privately. Changed: one single-sentence question per message instead of numbered rounds, no playback chunks or section walkthrough, an explicit brainstorm-or-grill choice made once per task, a stop rule tied to the spec gate line, and dropped the visual companion, spikes, sizing table, and skip-the-questions offer. -->
