---
name: principle-fix-root-causes
description: "Apply when debugging, or when asked to patch over a symptom with a default, guard, retry, or try/except. Trace the symptom back to the first place the system went wrong and fix it there. A guard is a fix only when the state it handles is legitimate."
disable-model-invocation: true
---

# Fix Root Causes

Fix the fault, not the place where it showed up. The symptom is where a wrong state became visible. The root cause is the first place the system did something it shouldn't, or failed to handle a state it should.

**Why:** A symptom fix hides the evidence and leaves the fault free to surface somewhere else. Each one makes the system harder to reason about, because the code now carries a workaround for a bug nobody named.

**Pattern:**
- **Reproduce first,** then trace backward. Ask "why" at each step until the answer is a wrong decision in the code, not a consequence of an earlier one.
- **Instrument, don't guess.** Read the actual error and the actual state at each step. Find where the bad value first appears, such as the serializer that drops a field or the cache that returns an old entry.
- **Ask whether the state is legitimate.** If the system may be in that state, the code that broke on it is the root cause, and handling it there is the fix. If the state should never exist, a check where it broke hides the bug. Fallback defaults, retries, swallowed errors, and clamped values are the usual masks.
- **Suspect persisted state** when something fails only after a restart: config files, caches, lock files, and serialized state.
- **Fix the pattern, not the instance.** Find every place with the same fault and fix them all.
- **Leave a signal.** If the deciding fact took a deep dig, propose the cheap, always-on check or log line that would have shown it at first look.

**Not this:**
- Catching the `KeyError` in a dashboard and showing "n/a" when an upstream serializer drops fields whose value is empty, so every other reader of that payload still breaks.

<!-- Adapted from pstack/skills/principle-fix-root-causes/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: symptom vs root cause, reproduce and ask why, instrument, the legitimate-state test, persisted state after restarts, fix the pattern, the always-on signal. Changed: merged eight bullets into six, added fallback defaults to the masks and a Not this, dropped the paragraph-long-comment line. -->
