# Example sessions

How the skill should behave. Invented data (org `contoso`, project `Data`, team `Data Platform`), not real runs. Time is in days, the team's unit.

- [Setup](#setup)
- [Show my cards](#show-my-cards)
- [Log time](#log-time)
- [Close a card with impact](#close-a-card-with-impact)
- [Create a task](#create-a-task)
- [Comments](#comments)
- [Write acceptance criteria](#write-acceptance-criteria)
- [Plan my sprint](#plan-my-sprint)

---

## Setup

Core setup only: about two minutes. Tags, custom fields and acceptance-criteria style are collected later, the first time they are needed.

```text
You:   Set up the ado skill

Agent: az ✓ · azure-devops extension ✓ · logged in as you@contoso.com ✓
       Org, project and team? I won't guess.

You:   contoso, project Data, team Data Platform

Agent: Saved org and project as az defaults. Process template: Agile ✓
       Does your team estimate in hours or days? How many hours is a day?

You:   days, 8

Agent: A few team rules (defaults in brackets):
       1. Must every card have a parent? [yes]
       2. Are bugs created here, or in another system? [here]
       3. Do cards arrive from another system with a title prefix? [none]
       4. Ask for a one-line Impact note when you close a card? [yes]

You:   1 yes. 2 ExternalTracker. 3 ExternalTracker, prefix EXT. 4 yes

Agent: PREVIEW of C:\Users\you\.config\ado-boards\config.md
         Org contoso · Project Data · Team Data Platform · Me you@contoso.com
         Units: days, 8 h/day
         Rules: parent required · bugs created in ExternalTracker · cards from
                ExternalTracker (prefix EXT), comment sync unknown · Impact note on close
         Not set yet: custom fields, priority tags, acceptance-criteria style
       Write it?

You:   yes

Agent: Saved ✓. Next: "show my cards".
```

## Show my cards

```text
You:   Show my cards

Agent: Your open cards (6). ★ = current sprint (Sprint 21)

       Active
         ★ #812  Task        Incremental load for orders           Remaining 1.5 d
         ★ #815  Task        Add row-count check to orders load    Remaining 0.5 d
       New
         ★ #820  User Story  Customer churn features table         (no AC)
         ★ #833  Bug         EXT0042117 Orders dashboard empty      (ExternalTracker)
           #790  Task        Document bronze layer naming          Remaining 1 d
       In Review
         ★ #801  User Story  Daily FX rates ingestion
```

## Log time

```text
You:   Spent 3h on #812

Agent: #812: Completed 1 -> 1.375 d, Remaining 1.5 -> 1.125 d (3h at 8h/day). OK?
You:   yes
Agent: Read-back ✓
```

## Close a card with impact

```text
You:   Close #815

Agent: #815 still has 0.5 d Remaining. Set it to 0?
You:   yes
Agent: One line on impact? (skip is fine)
You:   Catches missing rows before the finance report runs
Agent: #815: State Active -> Closed, Remaining 0.5 -> 0 d,
       comment "Impact: Catches missing rows before the finance report runs". OK?
You:   yes
Agent: Read-back ✓  https://dev.azure.com/contoso/Data/_workitems/edit/815
```

## Create a task

```text
You:   Create a task: backfill orders for January

Agent: First card you create here, so I checked your team's Task fields:
       Custom.WorkType (Dev / Support / Analysis) is required. Added to config ✓
       Every card needs a parent. Story ID, or keywords to search?
You:   orders

Agent: Open stories matching "orders":
       1. #805  Orders incremental pipeline        Active   Sprint 21
       2. #742  Orders data quality checks         New      Sprint 22
You:   1

Agent: PREVIEW
         Task "Backfill orders for January" under #805
         Area Data\Platform · Sprint 21 (from #805) · Assigned to you
         Estimate: ? days · Custom.WorkType: ? (Dev / Support / Analysis)
       Estimate and work type?
You:   1 day, Dev
Agent: Create with Estimate 1 d, Remaining 1 d, WorkType Dev?
You:   yes
Agent: Created #841, linked to parent #805. Read-back ✓
```

## Comments

```text
You:   Edit my comment on #812 from yesterday

Agent: Comments on #812:
         9921  you       2026-10-21  "Waiting on source team for the updated_at column"   ← yours
         9930  Anan      2026-10-21  "Column added in UAT"
       #9921: change to what?
You:   Source team added updated_at in UAT, testing now
Agent: OLD: Waiting on source team for the updated_at column
       NEW: Source team added updated_at in UAT, testing now
       OK?
You:   yes
Agent: Updated ✓

You:   Remove Anan's comment
Agent: I can only edit or remove your own comments. #9930 is Anan's.
```

## Write acceptance criteria

```text
You:   Help me write AC for #820

Agent: First time writing acceptance criteria. May I read your team's last 10
       closed stories to match their style?
You:   yes
Agent: Your team writes 3 to 5 bullets, no Given/When/Then. Saved to config ✓

       #820 "Customer churn features table" has no description or AC.
       Tell me what you know.
You:   Analysts need one table with churn features per customer for the model.

Agent: Clarifying:
       1. Who needs it, and what does done look like?
       2. Source and which customers are in scope?
       3. Grain: one row per customer per day, or per customer?
       4. How would someone else check pass vs fail (freshness, counts, owner)?
You:   1 analysts / churn model ready. 2 crm.customers + silver.orders, active.
       3 per customer per day. 4 by 07:00, row count matches active customers,
       Mali confirms.

Agent: DRAFT
       Description: Analysts need a daily churn features table, one row per active
       customer per day, built from crm.customers and silver.orders, for the churn model.
       Acceptance criteria:
       - One row per active customer per day; no duplicate (customer_id, date)
       - Row count per day matches active customers in crm.customers
       - Table is refreshed by 07:00 daily
       - Mali (analytics) confirmed the output
       Write to #820?
You:   yes
Agent: #820: Description and Acceptance Criteria written. Read-back ✓
```

## Plan my sprint

```text
You:   Plan my sprint

Agent: Priority tags aren't set yet. Tags on your cards (last 90 days):
       pipeline-failure (11), backfill (6), adhoc-request (5), tech-debt (3).
       Which mean "do first"? (skip is fine)
You:   pipeline-failure
Agent: Saved to config ✓

       Sprint 21 · your open cards, in suggested order:
       1. #812  Incremental load for orders        blocks #830 (Somchai)
       2. #801  Daily FX rates ingestion           already In Review, finish it
       3. #833  EXT0042117 Orders dashboard empty   tag pipeline-failure · ExternalTracker
       4. #820  Customer churn features table      Priority 2
       Last: #790 Document bronze layer naming     blocked by #770 (Anan, New)

       Not ready: #820 has no estimate.
       Question: #770 blocks #790. Ask Anan, or leave #790 for next sprint?

       Did NOT: change anything on the board.
```
