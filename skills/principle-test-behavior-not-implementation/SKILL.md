---
name: principle-test-behavior-not-implementation
description: "Apply when you write, change, or keep a test. Assert what the code's users can observe through its public interface, so the test fails when that behavior breaks and keeps passing when only the internals change."
disable-model-invocation: true
---

# Test Behavior, Not Implementation

A test is a claim about what the code does for its users: a caller, an end user, or another service. Behavior is what they observe through the interface they use, such as return values, errors, state they can read back, and effects on outside systems. Implementation is everything else: private helpers, internal call order, and intermediate data.

**Why:** A test pinned to internals breaks on every refactor and still catches no bug. A test looser than the contract passes while the behavior is broken. Only a behavior test does both jobs.

**Pattern:**
- **Imagine two edits.** Break the behavior (a wrong value, a skipped effect, an effect done twice): the test must fail. Restructure the internals with the same results: the test must pass. Rewrite or delete any test that fails either one.
- **Drive it through the public interface** with a concrete input, the way a user would. Don't call or mock private helpers.
- **Derive the expected value from the requirement,** not from a run of the code. A 30-day trial that starts on 2026-01-31 ends on 2026-03-02 because the rule counts days.
- **Mock only real boundaries.** The payload an external service receives is behavior, because that service observes it. A call to an internal helper is not.
- **Assert the contract, no less and no more.** The error type callers branch on is the contract. An exact message nobody reads is not. Cover the edges the contract names, such as a month end or a leap day.
- **Invariants count as behavior.** A key that must exist in two tables, or a compile-time type check, is a valid test.

**Not this:**
- Mocking `Subscription._days_left` to return 3 and asserting that `_send_reminder` was called once.

<!-- Adapted from pstack/skills/principle-test-behavior-not-implementation/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: behavior vs implementation, the two imagined edits, drive through the users' interface, derive expected values from the requirement, mocked external payloads count, assert the contract, invariants. Changed: compressed five paragraphs into six bullets, added the Why and a subscription example. -->
