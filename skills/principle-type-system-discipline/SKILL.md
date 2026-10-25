---
name: principle-type-system-discipline
description: "Apply when designing types, reviewing a function signature, or writing code in a statically typed language or with type hints. Make illegal states unrepresentable with tagged unions, handle every variant exhaustively, brand semantic primitives, parse external data at boundaries, and derive types from the schema that owns the shape."
disable-model-invocation: true
---

# Type System Discipline

Make the type checker reject impossible states, mixed-up primitives, and unhandled variants. Define special cases out of existence instead of adding handlers for them.

**Why:** The type checker checks every call site on every build, for free. A runtime check fires only on the path that happens to run, and a comment never fires.

**Pattern:**
- **Tagged unions for states that carry different data.** A network connection is Connecting, Open with a socket, or Closed with an error, and each variant holds only its own fields. A closed connection then cannot hand out a socket. Use a discriminated union in TypeScript, an enum with data in Rust or Swift, a sealed class in Kotlin, or dataclasses joined by a `Union` with `Literal` tags in Python.
- **Exhaust the variants.** Switch on the tag with an exhaustiveness check (`never`, `match`, `assert_never`), so a new variant breaks the build at every switch that misses it.
- **Brand semantic primitives.** `UserId` and `OrderId` are both strings underneath, so give each its own type (a branded type, newtype, or `NewType`) and validate once at creation.
- **External data is untyped until parsed.** JSON, RPC payloads, environment variables, and database rows go through a parse function at the boundary, per `../principle-boundary-discipline/SKILL.md`.
- **Derive from the owner.** When a protobuf, OpenAPI spec, GraphQL schema, or migration owns a shape, generate the type from it instead of hand-writing a parallel one that drifts.

**Not this:**
- One `Connection` type with `state: str`, `socket: Socket | None` and `error: str | None`, where every reader guesses which optional fields are set.

<!-- Adapted from pstack/skills/principle-type-system-discipline/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: reject impossible states, define errors out of existence, brand primitives, parse at boundaries, derive from authoritative schemas. Changed: added the tagged-union and exhaustiveness bullets with per-language equivalents, the free-check reason and a Not this, dropped the TypeScript-skill pointer. -->
