---
name: principle-boundary-discipline
description: "Apply when wiring validation, error handling, or framework adapters, or when the same input is checked in several places. Validate and parse at system boundaries (requests, CLI args, config, files, external APIs), trust the parsed data inside, and keep business logic in pure functions."
disable-model-invocation: true
---

# Boundary Discipline

Validate, narrow types, and handle bad input where data enters the system. Inside, trust what the boundary produced and don't check it again. Business logic lives in pure functions, and the shell around them stays thin and mechanical.

**Why:** The same check in three internal functions is noise that suggests the data might still be bad. The copies also drift: one gets updated and the other two don't. Logic kept out of framework wiring can be tested without the framework.

**Pattern:**
- **Parse at the edge.** Turn raw input (request bodies, CLI args, config files, environment variables, database rows) into a domain value once, and return a clear error there when it fails.
- **Trust inside.** Internal functions take the parsed value and skip the checks the boundary already did. When you move validation to the edge, delete the internal re-checks in the same change.
- **Don't leak the boundary.** Expose domain concepts through the public surface, not transport, storage, or framework types.
- **Pure core, thin shell.** Parsing, pricing, scoring, and prompt building are pure transforms from input to result. Handlers and commands only call them.
- **Ask two questions of every check.** "Is this data crossing a boundary right now?" If not, the check is redundant. "Could this be a pure function the shell calls?" If yes, extract it.

**Not this:**
- A handler that passes the raw body straight through, then a service, a repository, and a mailer that each re-check the email format.

<!-- Adapted from pstack/skills/principle-boundary-discipline/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: guards at boundaries, trust internal types, pure business logic and a thin shell, don't re-export boundary types, the two tests. Changed: added the drift reason and delete-the-re-checks step, folded the applications lists into five bullets, dropped the prompt-construction and scoring specifics. -->
