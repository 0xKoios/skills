---
name: principle-build-the-lever
description: "Apply to any non-trivial work, not just bulk work: edits, migrations, analyses, checks, and changes to environments. Build the tool that does or proves it (codemod, script, generator, infrastructure as code) instead of working by hand. The tool is what a reviewer reruns."
disable-model-invocation: true
---

# Build the Lever

When the work isn't trivial, build the tool that does it instead of doing it by hand. A codemod, script, or generator does the work the same way every time, reruns for free, and gives the reviewer one artifact to read and rerun. Skip the lever only for a couple of obvious edits you can check at a glance. Applying this leaves a script, codemod, generator, or IaC change in the diff.

**Why:** Hand-done changes can only be re-verified by redoing them. A deterministic tool turns "trust me" into "run this". Hand edits to environments drift silently, and nobody can rebuild or review them.

**Pattern:**
- **Do the first unit by hand, then script it.** The hand edit teaches the recipe: imports, call sites, strings, and tests. Write the codemod, rerun it on that unit, and diff against your hand version to prove it. Then run it everywhere.
- **Make the lever safe to rerun.** A second run changes nothing, and it reports what it touched.
- **Pick the right lever.** A codemod or script for edits, a generator for repetitive files, a query or script for analysis, and a rerunnable check for verification.
- **Infrastructure as code, no hand edits to environments.** Change servers, cloud resources, pipelines, and config through versioned code (Terraform, migrations, deploy scripts), never through a console or a manual shell session.
- **One pass beats fan-out.** If the tool can process every unit, run it yourself instead of handing units to subagents.
- **Commit the lever** when the work outlives the session. Keep it small, a script and never a framework, per `../principle-laziness-protocol/SKILL.md`.

**Not this:**
- Editing 40 files by hand, or fixing a server setting in the cloud console, and asking the reviewer to trust that every spot was covered.

<!-- Adapted from pstack/skills/principle-build-the-lever/SKILL.md (cursor/plugins, MIT, Lauren Tan). Took: build the tool for non-trivial work, first unit by hand then prove by rerun, rerun-safe, one pass beats fan-out, the cite-means-a-file test. Changed: added IaC and no hand edits to environments, dropped the delegate-skill and sqlite specifics and the cross-links outside this set. -->
