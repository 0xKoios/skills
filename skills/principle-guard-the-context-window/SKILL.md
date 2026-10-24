---
name: principle-guard-the-context-window
description: "Apply when a task would pull a lot into context: many files, long logs, large command output, repeated reads, or wide fan-out planning. Route the bulk to a subagent or script, and keep only summaries in the main thread, never raw payloads."
disable-model-invocation: true
---

# Guard the Context Window

The main thread's context is the scarce resource. Send bulk reading to a subagent or a script, and bring back only the summary the task needs.

**Why:** A full context degrades reasoning, forces compression that drops details, and can stop progress. Two hundred raw log files crowd out the question they were read to answer.

**Pattern:**
- **Delegate bulk reads.** Give a subagent one precise question and an output format, such as "for each failed job: file, timestamp, first error line". It returns that summary, not the logs.
- **Or script it.** For mechanical extraction, a grep or short script beats an agent. It is cheaper and repeatable, and you read its output, not its input.
- **Read narrowly.** Search before reading, read only the slice you need, and don't reread what you already have.
- **Cap noisy output.** Pipe long commands through a filter, `head`, or `tail`, and reduce test runs to their failures.
- **Size the phases.** Limit files per phase and budget fan-out, so planning doesn't eat the window before the work starts.

**Not this:**
- Reading all 200 logs into the conversation one by one to look for "ERROR".

<!-- Adapted from pstack/skills/principle-guard-the-context-window/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: route bulk to subagents, keep summaries not payloads, the overflow reason, size phases and cap scope. Changed: added the rule paragraph, the script option, narrow reads, output caps and a Not this, dropped the mechanism-cost specifics. -->
