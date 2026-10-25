# Debugging

A loop for bugs, wrong output, and regressions. Work through the sections in order. A section you skip stays listed as `skip: <reason>`.

## Redact secrets

You'll show commands, output, and captured artifacts. Replace every secret with `<REDACTED>` before showing it, because chat transcripts get logged and shared. Read credentials from env vars so they never appear in a command. From a captured request or log, quote only the lines that carry the signal, because headers carry tokens.

## 1. Feedback loop first

Build one red-capable command before forming any hypothesis. With a command that goes red on this bug, bisecting and testing hypotheses become mechanical. Without one, reading code produces theories you can't check.

Ways to build it, roughly in this order:

1. **Failing test** at whatever seam reaches the bug: unit, integration, or end to end.
2. **curl or HTTP script** against a running dev server.
3. **CLI run on a fixture input,** diffing stdout against a known-good snapshot.
4. **Headless browser script** that drives the UI and asserts on the DOM, console, or network.
5. **Replay a captured trace.** Save a real request, payload, or event log to disk and replay it through the code path alone.
6. **Throwaway harness.** Start the smallest slice of the system that reaches the bug with one call.
7. **Property or fuzz loop.** For "sometimes wrong", run many random inputs and catch the failing one.
8. **Bisect.** When the bug appeared between two known states (commits, versions, datasets), script the check and run `git bisect run`.
9. **Differential.** Run the same input through the old and new version, or two configs, and diff the output.

For a bug in data (wrong numbers, missing or duplicated rows), use the data repro methods in the data-change playbook.

**Tighten it.** Make it faster (narrow scope, skip unrelated setup), sharper (assert the exact symptom, not "didn't crash"), and deterministic (pin time, seed randomness, isolate the filesystem). A slow, flaky loop wastes every later step.

**Flaky bugs.** Aim for a higher reproduction rate, not a clean repro. Loop the trigger, add load, narrow timing windows. A bug that fails half the time is debuggable, and one that fails 1% of the time isn't yet.

**Done when** you can name one command that you've already run, with its output shown, and that:

- drives the real code path and asserts the user's exact symptom, so it can go red now and green after the fix;
- gives the same verdict every run, or a pinned high rate for flaky bugs;
- runs in seconds;
- runs without a human.

**No loop after trying the list:** stop and say so. List what you tried, and ask for access to an environment that reproduces it, a redacted artifact (log, dump, recording), or permission for temporary instrumentation. Don't hypothesise without a loop, because nothing could confirm the result.

## 2. Minimise the repro

Run the loop and confirm it shows the failure the user described, not a nearby one. A different failure leads to a fix for the wrong bug.

Then cut inputs, callers, config, data, and steps one at a time, rerunning after each cut. Keep only what the failure needs. You're done when removing any remaining piece turns the loop green. A minimal repro leaves fewer suspects and becomes the regression test.

## 3. One-line hypotheses

List 3 to 5 ranked hypotheses before testing any. One hypothesis anchors you on the first plausible idea.

Each is one falsifiable line: "If X is the cause, changing Y makes the bug go away." A hypothesis without a prediction is a vibe, so sharpen it or drop it.

Post the list and keep working without waiting for a reply. The user may re-rank it from what they know, but stopping for them stalls the loop.

## 4. Probe

- **Probes run on dev or sample environments only.** A probe that would touch production isn't run, because a probe there can change what users see. Ask the user instead, saying what you wanted to check and why (`../../principle-look-before-you-write/SKILL.md`).
- **One variable per probe,** each tied to one hypothesis's prediction. Changing two things at once tells you nothing about either.
- **Prefer a debugger or REPL,** then targeted logs at the boundaries that split hypotheses. Never log everything and grep.
- **Tag every debug log** with `[DEBUG-<4 hex>]`, for example `[DEBUG-a4f2]`, using one tag per session. Cleanup is then one grep, and an untagged log survives into the commit.
- **Performance bugs:** take a baseline measurement first (timer, profiler, query plan), then bisect. Logs mislead on timing.
- **Every number quotes its command.** Show the command that produced each count, timing, or row total next to it, so the user can rerun it (`../../principle-explain-the-number/SKILL.md`).
- **When evidence refutes a hypothesis,** revert the changes it motivated. Leftover edits from a dead theory become code nobody can justify.
- **Two fixes resting on the same premise have both failed:** write the premise down and escalate to the user.

## 5. Fix

1. **List dependents before the fix.** Name the callers, jobs, and consumers of the code you'll change, and how each is affected (`../../principle-look-before-you-write/SKILL.md`).
2. **Turn the minimal repro into a failing test** at a seam that exercises the real bug pattern. If the only seam is too shallow to reproduce the bug, record that as a finding and don't write a test that gives false confidence.
3. **Commit the failing repro before the fix.** History then shows the test failing without the fix and passing with it (`../../principle-sequence-verifiable-units/SKILL.md`).
4. **Apply the smallest fix the evidence justifies** at the root cause (`../../principle-fix-root-causes/SKILL.md`). A belt-and-braces change that "might help" is a hypothesis, not a fix, so it doesn't ship.
5. **Watch the test pass, then rerun the original loop** on the full, unminimised scenario.

## 6. After the fix

- **Ask about a backfill or state repair.** Rows, caches, or files written while the bug was live may still be wrong. Ask whether to repair them, with the range and cost. Never run one without a yes, because a repair writes to data others read.
- **Clean up.** Grep the debug tag and remove every hit. Delete throwaway harnesses. Rerun the loop once more.
- **Write the confirmed hypothesis in the commit or PR message,** so the next person debugging this area starts from it.

<!-- Adapted from skills/engineering/diagnosing-bugs/SKILL.md (mattpocock/skills, MIT, Matt Pocock) and pstack/skills/poteto-mode/playbooks/bug-fix.md (cursor/plugins, MIT, Lauren Tan). Took: from diagnosing-bugs the redact rule, feedback-loop-first with the ways-to-reproduce list, tightening, flaky bugs, the red-capable completion criterion, minimise, 3 to 5 falsifiable ranked hypotheses, one-variable probes, tagged debug logs, the perf branch, the correct-seam regression test, and cleanup; from bug-fix the failing repro committed before the fix, reverting what refuted hypotheses motivated, and the smallest change the evidence justifies. Changed: hypotheses are one line and posted without waiting, probes are limited to dev or sample environments, every number quotes its command, dependents are listed before the fix, a backfill or state repair is asked about after it, data bugs point to the data-change playbook, a same-premise escalation was added, and the HITL script, GLOSSARY and ADR reads, and the pstack-only skills, commands, and model lines were dropped. -->
