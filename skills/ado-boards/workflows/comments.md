# Workflow: Comments

Goal: add, list, edit, and remove comments. Edit and remove: user's own only. How: `../mcp-tools.md` (MCP) or `../az/comments.md` (az).

- **MCP:** add, list, edit. Remove has no MCP tool → `../az/comments.md` if az is logged in; otherwise give the card URL for the web UI.
- **az:** add via `--discussion`; list/edit/remove via Comments REST (`az devops invoke`, preview API).

On failure: show the error and stop (guessed endpoints can hit the wrong comment).

## Add

1. External card → warn first.
2. Preview exact text: `Post to #512: "Waiting on review. PR #88" OK?` Spelling fixes only if asked; keep meaning.
3. After "yes", post and confirm.

Done when the new comment appears in a list or read-back.

## List

One line per comment: comment ID, author, date, first 80 characters. Mark own comments (author email = Me in config).

Done when the list is shown.

## Edit

1. List comments; pick the one meant ("my comment from yesterday"). Ambiguous → ask.
2. Author must be me; otherwise say only the author can edit.
3. Preview old and new text in full; wait for "yes".
4. Update; list again to confirm.

Done when the list shows the new text.

## Remove

1. Identify as in Edit; author must be me.
2. Show full comment (ID, date, full text): `Remove this comment from #512? This cannot be undone. Type yes to confirm.`
3. Explicit "yes" only; anything else → leave it.
4. Remove; list again to confirm it is gone.

Done when the comment is absent from the list.
