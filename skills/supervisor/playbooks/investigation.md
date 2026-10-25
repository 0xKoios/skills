# Investigation

A read-only question: how X works, why Y was built this way, whether Z is true. The deliverable is a cited answer, not a code change. There's no questioning phase, because the repo, its history, and its docs hold the facts. Start reading at once.

**Subagents:** Steps 1 to 3 delegate wide searches and fact lookups to read-only subagents when the question spans more than a few files. Each brief names the question, the paths to start from, and "do not edit files". Steps 4 to 6 stay in the main chat, because you own the answer and check every claim yourself.

1. Search the repo for the files, commands, and docs that can answer the question.
2. Read them, and run read-only commands to collect evidence. Change no files, because an edit turns the investigation into a fix (see **Re-routing** in the router).
3. For a "why" question, read the history of the lines involved with `git log -L` or `git blame`, then read the commits and PRs that introduced them.
4. Check each claim against its evidence. Cut a claim with nothing behind it, or label it a guess.
5. Check the question's premise against the evidence. When the premise is wrong, say so and show why.
6. Write the answer. Every claim cites `path:line`, a command with its output, or a doc link. For a choice between options, give a recommendation and each option's tradeoffs.

No PR. When the answer calls for a code change, stop and re-route to **Bug fix** or **Feature**.

**Reply:** the answer, with a citation on every claim. Then any wrong premise, and what the evidence couldn't settle. For "are we sure?" questions, give your real judgment and the reasons.

<!-- Adapted from pstack/skills/poteto-mode/playbooks/investigation.md (cursor/plugins, MIT, Lauren Tan). Took: read-only scope, cited explanation or recommendation as the deliverable, no PR, hand back to Bug fix or Feature when a code change follows, push back on a wrong premise. Changed: replaced the how, why, and unslop skill routes and the output template with plain search, read, history, and claim-check steps; every claim cites a file line, command, or doc; dropped the throughput checkpoint line; added the Subagents line and the no-questioning rule. -->
