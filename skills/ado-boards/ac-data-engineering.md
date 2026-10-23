# Acceptance criteria checklist for data work

Used by `workflows/write-description.md`. Pick only the categories that apply to the card, ask the question for each gap, then write 3 to 7 pass/fail bullets. Match the team style in config when it differs from these examples.

A good criterion can be checked by someone else as pass or fail: run a query, compare a number, see an alert. "Load works correctly" fails that test; "row count matches source for a test day" passes it.

| Category | Ask when | Question to ask | Example criterion |
|---|---|---|---|
| Correctness | data is loaded or transformed | How do we know the numbers are right? Which source to compare with? | Row count in silver.orders matches source for 2026-01-15, ±0% |
| Uniqueness | there is a key | What is the key? Can duplicates arrive? | No duplicate order_id in silver.orders |
| Reconciliation | numbers feed a report | Which report or total must it agree with? | Daily revenue total matches the finance report within 0.1% |
| Schema | new or changed table or columns | Which columns, types and nullability? Who reads this table? | Columns and types match the agreed schema; downstream models still build |
| Freshness | scheduled jobs | When must data be ready? What if the source is late? | Data available by 06:00 daily; late source data is picked up on the next run |
| Re-runnable | any job | What happens if it runs twice, or for past dates? | Re-running the same day gives the same result; backfill for a date range works |
| Incremental logic | incremental loads | Which column marks new or changed rows? | Only rows with updated_at after the last run are loaded |
| Observability | scheduled or critical jobs | Who gets told when it fails? Which data checks? | Failure alerts the team channel; null and duplicate checks run after load |
| Performance | large data or tight windows | Any runtime or cost limit? | Daily run finishes in under 20 minutes |
| Security | personal or sensitive data | Any PII? Who may see it? | Email and phone columns are masked for the analyst role |
| Handover | someone else uses the output | Who confirms it is done? Where is it documented? | Column descriptions in the data catalog; analyst confirmed the output |

Skip what does not apply: a one-off extract does not need freshness or observability; a schema-only change does not need performance.
