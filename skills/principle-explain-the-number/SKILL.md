---
name: principle-explain-the-number
description: "Apply before you trust, report, or act on a number: a speedup, regression, throughput, latency, row count, or eval result, including one the user hands you. Trace it to a measurement run or read this session, find what limits it, and rule out that it measured something other than the work. Never invent or repeat a number without evidence."
disable-model-invocation: true
---

# Explain the Number

Before a number goes in a PR, report, or decision, know where it came from and what limits it. A number you can't trace to a measurement made or read this session is an assertion, so don't write it down as a fact.

**Why:** "p99 latency down 40%" often measures a warm cache, a skipped step, a smaller input, or noise. A wrong number in a PR misleads every reader after you, and nobody can check it without its evidence.

**Pattern:**
- **Trace it first.** Name the run behind it: the command, the input, and the run count. If the user supplied the number and no measurement exists, run one or ask for it before repeating it.
- **Ask "why not double?"** Name what bounds the result, such as a CPU core, a lock, the disk, the network, or the load generator. Get it from a profile or system counters taken during a run. A guess from reading the code is not a limiter.
- **Rule out impostors with evidence.** The usual ones are errors, cached or skipped work, code that never ran, an untuned baseline, noise, and a piece too small to matter end to end.
- **Repeat the measurement.** Run before and after several times on the same machine and input, and report the median and spread.
- **Keep the evidence with the number.** Put the run count, spread, and limiter in the PR or a linked artifact.
- **Apply it to eval results too.** Did every trial do the task, and does the gap hold across trials and models?

**Not this:**
- Putting "p99 latency down 40%" in the release notes from one cold run before and one warm run after.

This checks what a number means. `../principle-prove-it-works/SKILL.md` checks that an output is real.

<!-- Adapted from pstack/skills/principle-explain-the-number/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: why-not-double, name the limiter from a profile, rule out what else it measures, keep run count and spread with the number, the eval-result questions. Changed: added the user's Evidence over Assertion rule (trace every number to this session, never invent or repeat one), the repeat-runs bullet and a Not this, dropped the benchmark-checklist skill. -->
