---
name: principle-exhaust-the-design-space
description: "Apply when facing a novel interaction, protocol, or architectural decision with no precedent in the codebase, or a product decision that depends on feel. Build 2 or 3 competing sketches and compare them side by side before committing."
disable-model-invocation: true
---

# Exhaust the Design Space

When a decision has no precedent in the codebase, don't commit to the first design that comes to mind. Sketch 2 or 3 genuinely different approaches, compare them against criteria written down in advance, and then choose. When the codebase has a clear precedent, follow it instead.

**Why:** The first idea is anchored on whatever you saw last. A novel design is expensive to undo once callers depend on it. A few cheap sketches surface tradeoffs that a single design hides, such as failure modes, latency, and operational cost.

**Pattern:**
- **Write the criteria first.** Name what matters before sketching, for example correctness under failure, latency, complexity, and ease of operating it. That keeps the comparison honest.
- **Make the sketches differ in kind.** For a rate limiter: a token bucket in each process versus a central counter in a shared store versus a limiter at the proxy. Variations of one idea don't count.
- **Keep each sketch throwaway.** Each is a short design note or a small prototype, built through the Prototype playbook or one subagent per sketch.
- **Compare side by side.** Score each sketch against the criteria and run the riskiest scenario through all of them, such as a traffic burst, a node restart, or the shared store going down.
- **Commit and record why.** Choose one, note why the others lost, and delete the throwaway code.

**Not this:**
- Building the first rate-limiter idea all the way to production and finding its failure mode in an incident.

<!-- Adapted from pstack/skills/principle-exhaust-the-design-space/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: 2 or 3 competing prototypes compared side by side for novel decisions, including ones that depend on feel. Changed: dropped arena, builds sketches through the Prototype playbook or subagents, and added criteria-first, differ-in-kind, and a rate-limiter example. -->
