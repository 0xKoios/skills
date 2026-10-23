# Workflow: Comments

Goal: add, list, edit and remove comments on a card. Edit and remove apply to the user's own comments only. How: `../mcp-tools.md` (MCP) or `../az/comments.md` (az).

- **MCP:** add, list and edit have tools. Remove has no MCP tool: use the az command if `az` is logged in; otherwise give the user the card URL to remove it in the web UI.
- **az:** add uses `--discussion`; list, edit and remove use the Comments REST API through `az devops invoke` (a preview API).

If a call fails, show the error and stop rather than trying other endpoints: a guessed endpoint can act on the wrong comment.

## Add
1. Card from another system: give the warning first.
2. Show the exact text: `Post to #512: "Waiting on review. PR #88" OK?`. Fix spelling only if asked; never change the meaning.
3. After "yes", post and confirm.

## List
Show each comment on one line: comment ID, author, date, first 80 characters. Mark the user's own comments (author email equals "Me" in config).

## Edit
1. List the comments and identify the one meant ("my comment from yesterday"). If more than one matches, ask.
2. Check the author is me. If not, say only the author can edit it.
3. Preview old and new text in full, wait for "yes".
4. Update, then list again to confirm.

## Remove
1. Identify the comment as in Edit, and check the author is me.
2. Show the full comment (ID, date, full text) and ask: `Remove this comment from #512? This cannot be undone. Type yes to confirm.`
3. Only an explicit "yes" removes it. Anything else: do nothing.
4. Remove, then list again to confirm it is gone.
