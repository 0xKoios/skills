---
name: principle-experience-first
description: "Apply when product, UX, API, or feature-scope tradeoffs come up. Choose the user's experience over implementation convenience; ship fewer polished features over more rough ones."
disable-model-invocation: true
---

# Experience First

When implementation convenience conflicts with the experience of whoever uses the work, choose the experience. The user is whoever consumes it: the end user of an app or CLI, the colleague who imports a library or calls an API, and the engineer who maintains the code next.

**Why:** Implementation cost is paid once, by us. Friction is paid on every use, by every user. A tool that is easy to build but awkward to run gets worked around or abandoned.

**Pattern:**
- **Start from the user's first run.** Describe what they type, what happens, and what they see when it goes wrong, before choosing the implementation.
- **Default sensibly.** It should work with zero setup. Make configuration optional and layered: defaults, then a config file if present, then env vars and flags.
- **Justify every option and control.** Each one is a decision you push onto the user.
- **Ship less, ship better.** Three polished features beat ten rough ones. Every feature serves the core loop or gets out of the way.
- **Get the details right.** Clear errors that say what to do next, helpful output, and consistent naming.
- **Prototype when feel matters.** A throwaway sketch is cheaper than a production rewrite.

**Not this:**
- Requiring a config file before the first command works because parsing defaults is more code for us.

<!-- Adapted from pstack/skills/principle-experience-first/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: delight over convenience, justify every option, ship less ship better, the broad definition of the user. Changed: generalized beyond UI to CLIs and APIs, added Why, first-run and sensible-defaults patterns, and a CLI example. -->
