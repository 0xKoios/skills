# Opening a PR

Run at the end of every build or fix playbook. A PR is a briefing for a reviewer who has the diff, so it says why, what it leaves out, and how you proved it.

**Subagents:** Every step is yours. A subagent that opens a PR drafts the title and body, then returns to you without pushing or posting. Pushes and posts need the user's yes in the main chat, because they follow **Escalation** in the router.

**Outward rule.** Before every push, `gh pr create`, PR comment or thread reply, and `gh pr edit`, show the user the exact content (the title and body, the comment text, or the branch and commits being pushed) and wait for a yes. Every force push goes to the user too. Commits land on a non-trunk branch, never on trunk.

1. Read `git status` and `git log` against the base branch.
2. Move unrelated work out of the diff (patch it out or use a fresh worktree), because a PR should carry one change.
3. Rebase the work into small, ordered commits, each landable on its own. Amend when a fix belongs in a commit you just made.
4. Write commit bodies that add information instead of restating the subject.
5. Check that no file under `docs/superpowers/` or `.superpowers/` is staged or committed. Specs and plans stay local, because the user keeps them out of GitHub.
6. Read the whole diff once and remove debug leftovers, dead code you added, and comments that restate the code.
7. Write the title as `type(scope): subject` with no trailing period. Use `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, or `perf`. Keep the subject short and imperative, and name a real symbol when one carries the change.
8. Write the body to a file as `##` sections in this order, dropping any with nothing to say. Use short sentences, few identifiers, and no walls of text, because the body becomes the squash commit.
   - `## Why`: the problem and the approach, in one to three sentences.
   - `## What changed`: one to three bullets. Name both sides of a rename.
   - `## Scope`: always present. What it covers and what it deliberately leaves out.
   - `## Tradeoffs`: only alternatives a reviewer would otherwise ask about.
   - `## Blast Radius`: who or what it touches, and why that is safe or risky.
   - `## Verification`: one to three bullets, each a real command you ran and its outcome. For a perf change, give one number with its unit as `before → after`.
9. Keep the body free of links to, and pasted text from, any local spec or plan. Describe the intent in your own words, because readers on GitHub can't open local files.
10. Show the user the branch, the commits to push, the title, and the body. Wait for a yes.
11. Push with `git push -u origin <branch>`. If the history was rewritten, push with `--force-with-lease` instead, never `--force`, and only on the user's yes to that exact command.
12. Run `gh pr create --title "<title>" --body-file <body file>`. Add `--base <parent-branch>` for a stacked PR. Omit `--draft`, because a PR that opens as a draft hides from reviewers.
13. Read the PR back with `gh pr view <number> --json state,isDraft,baseRefName,url`.
14. If it opened as a draft, show the user that and run `gh pr ready <number>` on their yes.
15. Post the URL and keep building. Opening a PR starts no babysit.
16. Run **Babysit** only when the user asks after the whole stack exists, because a babysit per PR stalls the build and spends checks on commits later work restarts.

For a stack, prefer several narrow PRs to one large one. The root PR targets trunk. Each child branch rebases onto its parent's exact tip and its PR targets the parent branch. When a parent merges, **Shipping** moves its child onto trunk.

PR links take the form `https://github.com/<owner>/<repo>/pull/<number>`.

**Reply:** the PR URL, its base, the title, the verification bullets, and whether anything waits on the user (a push or a merge).

<!-- Adapted from pstack/skills/poteto-mode/playbooks/opening-a-pr.md (cursor/plugins, MIT, Lauren Tan). Took: small ordered commits, the Conventional Commits title, the section order and short-body rules, ready-not-draft, stacks as base-branch chains, and no babysit on open. Changed: replaced the writing and deslop skills, the forge preference, the built-in PR tool, and subagent loop rules with plain steps on gh; added the ban on local spec and plan content, one show-then-wait rule for every push and post under Escalation, and a read-back of the PR. -->
