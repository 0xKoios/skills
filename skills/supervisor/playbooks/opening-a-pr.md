# Opening a PR

Run at the end of every build or fix playbook. A PR is a briefing for a reviewer who has the diff, so it says why, what it leaves out, and how you proved it.

**Subagents:** Every step is yours. A subagent that opens a PR follows these steps, posts the URL, and returns to you without babysitting. Pushing and merging are never delegated, because they follow **Escalation** in the router.

1. Read `git status` and `git log` against the base branch. Move unrelated work out of the diff first (patch it out or use a fresh worktree), because a PR should carry one change.
2. Rebase the work into small, ordered commits, each landable on its own. Amend when a fix belongs in a commit you just made. Write commit bodies that add information, not a restatement of the subject.
3. Check that no file under `docs/superpowers/` or `.superpowers/` is staged or committed. Specs and plans stay local, because the user keeps them out of GitHub.
4. Read the whole diff once and remove debug leftovers, dead code you added, and comments that restate the code.
5. Write the title as `type(scope): subject` with no trailing period. Use `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, or `perf`. Keep the subject short and imperative, and name a real symbol when one carries the change.
6. Write the body as `##` sections in this order, dropping any with nothing to say. Use short sentences, few identifiers, and no walls of text, because the body becomes the squash commit.
   - `## Why`: the problem and the approach, in one to three sentences.
   - `## What changed`: one to three bullets. Name both sides of a rename.
   - `## Scope`: always present. What it covers and what it deliberately leaves out.
   - `## Tradeoffs`: only alternatives a reviewer would otherwise ask about.
   - `## Blast Radius`: who or what it touches, and why that is safe or risky.
   - `## Verification`: one to three bullets, each a real command you ran and its outcome. For a perf change, give one number with its unit as `before → after`.
7. Keep the body free of links to, and pasted text from, any local spec or plan. Describe the intent in your own words, because readers on GitHub can't open local files.
8. Check whether the branch is shared with other people (`git branch -r --contains HEAD`, then ask the user if the answer isn't clear). If it is shared, ask the user before pushing and wait for a yes. A push reaches other people, and a force push can destroy their work (see **Escalation** in the router).
9. Push a branch only you use with `git push -u origin <branch>`. Use `--force-with-lease`, never `--force`, and only on such a branch.
10. Run `gh pr create --title "<title>" --body-file <body file>`. Add `--base <parent-branch>` for a stacked PR. Omit `--draft`, because a PR that opens as a draft hides from reviewers.
11. Read the PR back with `gh pr view <number> --json state,isDraft,baseRefName,url`. Confirm it is open, not a draft, and targets the right base. Run `gh pr ready <number>` if it opened as a draft.
12. Post the URL and keep building. Opening a PR starts no babysit. Run **Babysit** only when the user asks after the whole stack exists, because a babysit per PR stalls the build and spends checks on commits later work restarts.

For a stack, prefer several narrow PRs to one large one. The root PR targets trunk. Each child branch rebases onto its parent's exact tip and its PR targets the parent branch. When a parent merges, **Shipping** moves its child onto trunk.

PR links take the form `https://github.com/<owner>/<repo>/pull/<number>`.

**Reply:** the PR URL, its base, the title, the verification bullets, and whether anything waits on the user (a shared-branch push or a merge).

<!-- Adapted from pstack/skills/poteto-mode/playbooks/opening-a-pr.md (cursor/plugins, MIT, Lauren Tan). Took: small ordered commits, the Conventional Commits title, the section order and short-body rules, ready-not-draft, stacks as base-branch chains, and no babysit on open. Changed: replaced the writing and deslop skills, the forge preference, the built-in PR tool, and subagent loop rules with plain steps on gh; added the ban on local spec and plan content, a shared-branch push check under Escalation, and a read-back of the PR. -->
