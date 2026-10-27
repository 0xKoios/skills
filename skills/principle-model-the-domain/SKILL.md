---
name: principle-model-the-domain
description: "Apply when writing stateful logic, or when code branches heavily, keeps several flags in sync, or repeats the same shape assumption across files. Encode the domain in one data structure, such as a state machine, tagged union, or lookup table, so invalid states can't exist and branches disappear."
disable-model-invocation: true
---

# Model the Domain

Put the domain's rules in a data structure instead of scattering them across conditionals. A structure that matches the domain makes invalid states unrepresentable and deletes branches. Choose it when you write the code, because recovering it later looks like a refactor and gets deferred.

**Why:** Four lifecycle booleans allow 16 combinations when the domain has four real states. Every check that reads two flags is a place where they can disagree. One state field holds exactly the states that exist.

**Pattern:**
- **A state machine over flags.** Replace a document's `is_draft`, `is_in_review` and `is_published` with one status field and a table of allowed transitions. An illegal move then fails in one place, not in every method.
- **A lookup table over a branch chain.** A map or registry from kind to handler replaces an if/else chain repeated across files. A new kind is one new entry.
- **A typed model over loose shapes.** One record or class replaces dicts whose keys every caller assumes. Encode it in types per `../principle-type-system-discipline/SKILL.md`.
- **Organize by domain knowledge, not execution order.** A module that owns pricing beats modules named load, validate, transform and save that each repeat pricing rules.
- **Fit the structure to the reads.** Use a queue, index, tree, or normalized collection when the access pattern calls for it. When nothing fits, write down what the code must never allow, then find the structure that encodes exactly that.
- **Don't force it.** Plain code wins when the shape is clear, local, and unlikely to grow. Reject an abstraction that adds indirection without removing a branch, a duplicated rule, or an invalid state.

**Not this:**
- Adding `is_archived` as a fourth boolean on a document and one more `elif` to every method that already checks the other three.

<!-- Adapted from pstack/skills/principle-model-the-domain/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: structure over scattered conditionals, the reach-for list, don't force an abstraction, the grows-a-branch and second-boolean signs. Changed: rewrote as Why, Pattern and Not this, added the flag-combination reason and the transition table, merged the reach-for list into six bullets. -->
