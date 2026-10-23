# Workflow: Write a description and acceptance criteria

Goal: turn what the user knows into a clear description and testable acceptance criteria, in the team's style. Used on its own ("help me write #520") and by `create-card.md` for new stories. How: `../mcp-tools.md` (MCP) or `../az/write-description.md` (az); on Windows HTML writes also read `../az/windows.md`.

If the config's acceptance-criteria team style is `not set yet`, collect it first (setup, "On first need"), or carry on with general defaults if the user says skip.

## Steps

1. **Context** — if the card exists, read it and its parent. Ask the user to say what they know in their own words.
2. **Clarify description** — ask until these are clear (skip what the card or user already answered; max 5 questions at a time):
   - Who needs it and why?
   - What does done look like?
   - What is out of scope?
   - Dependencies or links?
3. **Clarify acceptance criteria** — for each outcome in the description, ask how someone else would check pass vs fail (run something, compare a number, see a state). Prefer concrete checks over "works correctly".
4. **Draft**
   - Title: short outcome
   - Description: 2 to 4 sentences — who, problem, intended result, links or notes
   - Acceptance criteria: 3 to 7 pass/fail bullets in the team style
   - Out of scope: one line, if anything was excluded
5. **Iterate** with the user until they are happy.
6. **Write** (existing card): preview which fields change, wait for "yes", write `System.Description` and `Microsoft.VSTS.Common.AcceptanceCriteria` as HTML (`<p>`, `<ul><li>`), read-back. External card: warn first.

Done when description and AC are agreed, and (if writing) previewed, written, and read back.

Add only criteria the user agreed to; turn any assumption into a question. Criteria are what the work is tested against, so an unagreed one becomes a hidden requirement.
