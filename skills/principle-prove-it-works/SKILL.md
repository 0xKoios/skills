---
name: principle-prove-it-works
description: "Apply after finishing a task and before calling it done, and before reporting any result. Check the real artifact (run the code, read the actual value, inspect the diff), not a proxy like 'it compiles' or a self-report. Never invent a result, number, or schema; every claim traces to something run or read this session."
disable-model-invocation: true
---

# Prove It Works

Before you call a task done, check the real output directly. Run the changed code on real input, read the actual value, and inspect the diff. Compiling, type checking, an unrelated green test, and an agent's "done" are proxies, not proof.

**Why:** Unverified work has unknown correctness. A proxy feels cheaper than looking, but acting on a wrong inference costs far more than the check. A claimed result that nobody ran is a guess presented as a fact.

**Pattern:**
- **Run the real thing.** Call the changed function on real inputs, hit the endpoint, or run the job, and show its output in your reply.
- **Compiling is not proof.** It shows the syntax is valid, not that the behavior is right.
- **Read the source, not a stand-in.** Check the row in the table, not the log line. Check the live process, not its pid file. Check the rendered output, not a file's modification time.
- **Never invent a result.** Don't state a number, schema, output, or pass count that you didn't produce or read this session. Name the command, file, or query behind each claim. When you couldn't run it, say "not verified" and give the command that would verify it.
- **Script the check when you can.** A deterministic script reruns the same comparison and leaves output a reviewer can rerun instead of trusting your word.
- **Suspect the observation first.** When a check fails, rule out the check itself before blaming the system.

**Not this:**
- "The migration ran without errors, so the table is backfilled," or "all 12 cases pass" with no run in the session to back it.

<!-- Adapted from pstack/skills/principle-prove-it-works/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: check the real thing not a proxy, read the actual value, suspect the observation method, script the check and keep its output. Changed: added the user's Evidence over Assertion rule (no invented results, every claim traced to this session), the compiling-is-not-proof bullet, dropped the show-me-your-work skill reference. -->
