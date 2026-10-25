# Test-driven development

Red, then green, one slice at a time. This guide says where tests go, what makes one worth keeping, and what to avoid.

## Seams

A seam is the public boundary a test observes behavior through, without reaching inside. Tests live at seams, never against internals, so they survive refactors.

1. **Propose the seams** before writing any test. Give each a one-line note on what it catches and what it misses.
2. **Agree on them with the user, one question at a time:** "Should the parser's public `parse()` be the seam, since it catches every format bug but misses the file reader?" You can't test everything, and agreed seams put the effort on the paths that matter.
3. **Write no test at an unagreed seam.**

For data work, the data seams are listed in `../playbooks/data-change.md`.

## Vertical slices

One test, then one implementation, repeated.

1. **Write one failing test** for the next behavior.
2. **Run it and watch it fail** for the reason you expect. A test that never failed may not test anything.
3. **Write only enough code to pass it.** Don't build for tests you haven't written, because they encode guesses about behavior you don't understand yet.
4. **Run it and watch it pass.**
5. **Repeat** with the next behavior. Each test responds to what the last cycle taught you.

Refactor only when everything is green, never while a test is red, so a failure always points at one change.

Code that already exists without a test stays. Write the test, then break the code briefly to watch the test go red, so you know it can fail. Restore the code and confirm green.

## Assert observable behavior

Assert what a caller can see: return values, output, state read back through the public interface (`../../principle-test-behavior-not-implementation/SKILL.md`). A test named for what the system does ("user can check out with a valid cart") reads as a spec and survives a rewrite of the internals.

- **Verify through the interface.** Create a user, then fetch it with `getUser`, rather than querying the table behind it.
- **Expected values come from an independent source:** a known literal, a worked example, or the spec. Never recompute them the way the code does.
- **One logical assertion per test,** so a failure names one behavior.

## Mocks

Mock only at system boundaries: external APIs, time, randomness, and sometimes the database or filesystem (prefer a test database or a temp folder). Never mock your own modules, because the test then checks your wiring instead of your behavior.

At a boundary, make mocking easy:

- **Pass dependencies in** rather than building them inside the function.
- **Give each external operation its own function** (`getUser`, `createOrder`) instead of one generic `fetch`. Each mock then returns one shape with no branching in test setup.

## Anti-patterns

- **Implementation-coupled tests.** They mock internal collaborators, test private methods, assert call counts or order, or verify through a side channel. The tell: they break on a refactor that didn't change behavior.
- **Tautological tests.** The assertion restates the code, such as `expect(add(a, b)).toBe(a + b)` or a snapshot derived the same way the code derives it. They pass by construction and can never disagree with the code.
- **Horizontal slicing.** All tests first, then all code. The tests check imagined behavior and the shape of things, and lock in a structure before you understand the problem. Work in vertical slices instead.

<!-- Adapted from skills/engineering/tdd/SKILL.md, tests.md and mocking.md (mattpocock/skills, MIT, Matt Pocock). Took: seams as public boundaries agreed before testing, each with what it catches and misses; the three anti-patterns; red before green with one slice per cycle; behavior through the public interface; independent expected values; mocking only at system boundaries with injected dependencies and SDK-style functions. Changed: seams are agreed one question at a time, data seams point to the data-change playbook, a "watch it fail" step and a rule for existing untested code were added (no delete-it rule), refactoring is allowed once green, the code examples were cut to one-line rules, and the GLOSSARY, ADR, and codebase-design skill references were dropped. -->
