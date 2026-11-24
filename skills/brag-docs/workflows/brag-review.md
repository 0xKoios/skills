# Workflow: brag-review

Goal: turn existing **Entries** into a **Review pack** — a pasteable draft for a performance review, self-review or promo packet. How: read config (`../SKILL.md` §1); judge entries with `../references/evidence-and-categories.md`.

The output is a draft in chat. The **Store** changes only when the user asks to save evidence they add here.

## Gather

1. Read config. Missing → **`brag-setup`** first.
2. **Review period and audience** — confirm the period (e.g. "H1 2026") and what it is for (self-review form, promo packet, manager 1:1). Ask for the form's questions or headings if the user has them.
3. **Read entries** for the period from the **Store**: markdown → read **Store path**; notion → read **Notion target**. Chat-only, target `not set yet`, or unreadable → ask the user to paste their entries.

Done when every entry in the period is in hand. None found → offer **`brag-backfill`** for the period and stop.

## Select

Propose the **top 3–5** entries by impact (strongest evidence and widest benefit first), with one line each on why. The user confirms or swaps.

## Fill gaps

For each picked entry still marked `(evidence needed)` or with a vague result, ask one question: "What metric changed?", "Who was unblocked?", "Ticket ID or date?" Accept "nothing" and keep the entry qualitative. Numbers come only from the user.

## Draft

1. Group picks by impact theme (skip empty themes; use the form's headings instead when the user gave them):
   - Delivering results
   - Customer or team impact
   - Collaboration, mentoring, leadership
   - Growth and learning
2. Write each pick as a STAR narrative: **Situation** → **Task** → **Action** → **Result**, 2–4 sentences, first person, the user's voice. End with the evidence.
3. Check against **Anti-patterns** in the evidence reference. **Store owner** `personal` → keep the generalized wording from the store.
4. Show the **Review pack** as pasteable markdown, with any remaining gaps labeled.

## Save new evidence (optional)

If the user added evidence in **Fill gaps**, offer to update those entries in the **Store**. This is an edit the user asked for (§2 **Append-only**); preview the changed lines and write only after explicit **yes**, then apply §2 **Write footer**.

Done when the user has the Review pack — and, if they accepted, the store reflects the new evidence.
