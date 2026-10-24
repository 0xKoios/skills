---
name: principle-migrate-callers-then-delete-legacy-apis
description: "Apply when introducing a new internal API, function, or module while callers of the old one still exist. Migrate every caller and delete the old API in the same change, instead of keeping both or adding a compatibility layer."
disable-model-invocation: true
---

# Migrate Callers, Then Delete Legacy APIs

When a new internal API replaces an old one, move every caller to the new one and delete the old one in the same change. Don't leave a v1 beside a v2, a shim, or a "deprecated, migrate later" note.

**Why:** Two APIs double what readers must learn and what tests must cover, and they drift apart. "Keep it around" turns into forever, because new code keeps calling whatever already exists.

**Pattern:**
- **Find every caller first.** Search the code, then let the type checker or a failing import confirm you caught them all.
- **Migrate in one wave.** Use a codemod or script when there are more than a few call sites, per `../principle-build-the-lever/SKILL.md`.
- **Delete the old API in the same change,** along with its shims, aliases, and dead config. Nothing is left to call by accident.
- **Move the tests to the new contract.** Delete tests that only protected the old internals.
- **Take back the plain name.** Once the old one is gone, a `_v2` suffix has no reason to exist.
- **Check the precondition.** This applies when no external users depend on the old API. A published library, public endpoint, or another team's service gets a versioned deprecation instead, and you say so.

**Not this:**
- Adding `send_email_v2`, leaving 14 callers on `send_email` "for now", and a TODO to migrate them later.

<!-- Adapted from pstack/skills/principle-migrate-callers-then-delete-legacy-apis/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: migrate callers and delete the old API in one wave, move tests to the new contract, the no-external-users precondition. Changed: wrote the missing rule, Why and steps (find callers, codemod, delete shims, reclaim the name), and an external-users fallback. -->
