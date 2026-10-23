# Workflow: Write a description and acceptance criteria

Goal: turn what the user knows into a clear description and testable acceptance criteria, in the team's style. Used on its own ("help me write #520") and by `create-card.md` for new stories. How: `../mcp-tools.md` (MCP) or `../az/write-description.md` (az); on Windows HTML writes also read `../az/windows.md`.

If the config's acceptance-criteria checklist or team style is `not set yet`, collect it first (setup, "On first need"), or carry on with general defaults if the user says skip.

## Steps
1. **Context:** if the card exists, read it and its parent. Ask the user to say what they know in their own words.
2. **Gaps:** find what is missing for a clear card: who needs it and why, what done looks like, what is out of scope, dependencies.
3. **Checklist:** if the config says data engineering, go through `../ac-data-engineering.md` and pick only the categories that apply to this card.
4. **Questions:** ask only about the gaps, max 5 at a time. Do not ask what the card or the user already answered; repeated questions make people stop answering.
5. **Draft:**
   - Title: short outcome, e.g. "Incremental load for orders (bronze to silver)"
   - Description: 2 to 4 sentences: who needs it, the problem, the intended result, links or notes
   - Acceptance criteria: 3 to 7 pass/fail bullets in the team style. Each must be checkable by someone else (run a query, compare a number, see an alert).
   - Out of scope: one line, if anything was excluded
6. **Iterate** with the user until they are happy.
7. **Write** (existing card): preview which fields change, wait for "yes", write `System.Description` and `Microsoft.VSTS.Common.AcceptanceCriteria` as HTML (`<p>`, `<ul><li>`), read back. Card from another system: warning first.

Add only criteria the user agreed to; turn any assumption into a question. Criteria are what the work is tested against, so an unagreed one becomes a hidden requirement.
