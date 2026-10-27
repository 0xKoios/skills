# Supervisor in Claude Code

The supervisor and its playbooks use neutral words. Read this file once per session, then map each neutral word with the lists below. Never pass a field or value the tool schema rejects. If a mapping is missing, drop the field and say so in one line.

## Tools

- **Spawn a subagent:** the `Agent` tool. Use `subagent_type: "general-purpose"` for work that edits files and `subagent_type: "Explore"` for read-only lookups. Explore keeps Bash, so its brief also says "do not edit files", and you check `git status` afterward.
- **Isolated checkout:** `isolation: "worktree"` on the `Agent` call. Name the branch or commit the worker starts from.
- **Background:** omit it. Subagents run in the background by default and notify you when they finish.
- **Resume a subagent:** spawn a fresh one with the consolidated scope instead (see Subagents in the router).
- **Ask the user:** `AskUserQuestion`. In `-p` (print) mode it's absent, so ask in plain text as the last line of the reply.
- **Open a todo list:** `TodoWrite` when the session offers it. Otherwise keep the list in the reply and update it at each step.
- **Search:** `Grep` and `Glob`. When the session lacks them, use Bash with `rg`.

## Strongest model

For model escalation, spawn the fresh subagent with `model: "opus"` and the highest `effort` value the `Agent` schema lists (`max` when listed, else `xhigh`). `model` accepts only the names the schema lists. Pin no model anywhere else, because subagents follow the session default.

## Paths

- **Skills:** `.claude/skills/<name>/` in a project, `~/.claude/skills/<name>/` for the user.
- **Agent instructions:** **CLAUDE.md**, or **AGENTS.md** when no **CLAUDE.md** exists. A project-fact correction goes in the file the repo already uses.
- **Transcripts (for supervisor-reflect):** `~/.claude/projects/<slug>/<session>.jsonl`. The slug is the workspace's absolute path with each `/` and `.` changed to `-`, so `/Users/you/proj` is `-Users-you-proj`. The newest `.jsonl` in that folder is the current session. Its `<session>/subagents/` folder holds subagent transcripts. Read only this workspace's folder.

## Steps Claude Code can't do

When a step needs something Claude Code lacks, write one line in the reply, `Skipped in Claude Code: <step>. <reason>.`, and go on to the next step. Don't stop, ask, or retry. When a later step needs what the skipped step would have made, leave a placeholder and name it in the line.

<!-- Adapted from docs/harness/claude-code.md (cursor/plugins pstack, MIT, Lauren Tan). Took: read-once framing, Agent and AskUserQuestion mappings, Explore-keeps-Bash caveat, worktree isolation, fresh-agent-instead-of-resume, transcript path and slug rule, and the Skipped-in line. Changed: maps the supervisor's neutral words instead of Cursor names, drops the model rule file, setup step, Bugbot, Automations, and cloud agents, and adds the strongest-model rule for escalation. -->
