---
name: principle-look-before-you-write
description: "Apply before any irreversible change or one others depend on: production writes, schema or column changes, bulk updates, deletes, backfills, and reruns. List who depends on it, show a preview, and state the range and cost of any backfill before running it on a yes."
disable-model-invocation: true
---

# Look Before You Write

Before an irreversible change, or one that other people or systems depend on, look first and write second. List who depends on what you will change, show a preview of the effect, and state the range and cost of any backfill or bulk rerun. Then stop and wait for the user's yes before running the write.

**Why:** A production write can't be taken back by editing code. Downstream jobs, reports, and services read what you change, and a surprise there costs far more than a minute of looking. A preview turns "this should touch a few rows" into a number the user can check.

**Pattern:**
- **List the dependents.** Search code, queries, jobs, dashboards, and services for reads of the target, such as a column, table, endpoint, or file. Name each one and say how it would be affected.
- **Preview the effect.** Show a count of affected rows (the same WHERE clause wrapped in SELECT COUNT), a dry run, or a diff. Include a few sample rows or before-and-after values.
- **Make backfills explicit.** State the exact range (for example 2024-01-01 to 2024-12-31), how many rows or partitions that covers, and the cost in time, compute, or load on production.
- **Say how to undo it.** Name the rollback: a backup or snapshot of the affected rows, or the inverse statement.
- **Deliver all three now, even without access.** If you can't reach the code or the database, still write each item in this reply: name the likely dependents of the exact target (for example "`customers.tier` is read by the pricing service, loyalty emails, and the tier dashboard"), marked unverified; give the preview query and the count it returns, or "count: pending, run this"; and state the backfill's dates and estimated cost. Never defer an item to a later message.
- **Wait for a yes.** End with the preview and the plan, and run nothing that writes until the user approves. Reads and dry runs are fine before that.

**Not this:**
- Running the UPDATE on production and then reporting how many rows changed.

<!-- Adapted from docs/superpowers/specs/2026-10-23-supervisor-design.md, Principles section (0xKoios/skills, MIT, 0xKoios), which combines the user's "Blast radius before change", "Production writes need a preview" and "Backfills are explicit". Took: list dependents, preview, explicit backfill range and cost, run only on a yes. Changed: wrote it as a leaf with Why, Pattern and Not this, and added a rollback step and general examples. -->
