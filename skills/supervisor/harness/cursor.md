# Supervisor in Cursor

The supervisor and its playbooks use neutral words. Read this file once per session, then map each neutral word with the lists below. Never pass a field or value the tool schema rejects. If a mapping is missing, drop it and say so in one line.

## Tools

- **Spawn a subagent:** the `Task` tool. Set `readonly: true` for lookups and reviews, and leave it off for work that edits files. Pass file paths in the brief rather than attaching content.
- **Background:** `run_in_background: true` for independent work you fan out.
- **Resume a subagent:** spawn a fresh `Task` with the consolidated scope instead (see Subagents in the router).
- **Ask the user:** the `AskQuestion` tool. In the CLI's print mode (`cursor-agent -p`) ask in plain text as the last line of the reply.
- **Open a todo list:** Cursor's todo tool when the session lists it. Otherwise keep the list in the reply and update it at each step.

## Strongest model

For model escalation, spawn the fresh `Task` with the strongest model the `Task` schema lists, at its highest reasoning level. In the CLI, rerun with `--model <strongest>`, choosing from what `cursor-agent` lists. In the editor without a model field, ask the user to switch the model picker. Pin no model anywhere else.

## Paths

- **Skills:** `.cursor/skills/<name>/` in a project, `~/.cursor/skills/<name>/` for the user.
- **Agent instructions:** **AGENTS.md**. Cursor rules under `.cursor/rules/` also load, but corrections go in **AGENTS.md** unless the repo keeps that rule in a rule file.
- **Transcripts (for supervisor-reflect):** `~/.cursor/projects/<slug>/agent-transcripts/`. Read only this workspace's folder, newest file first.

## Steps Cursor can't do

When a step needs something this Cursor session lacks, write one line in the reply, `Skipped in Cursor: <step>. <reason>.`, and go on to the next step. Don't stop, ask, or retry. When a later step needs what the skipped step would have made, leave a placeholder and name it in the line.

<!-- Adapted from docs/harness/claude-code.md (cursor/plugins pstack, MIT, Lauren Tan). Took: the adapter shape, read-once framing, Task fields, plain-text fallback for asking, transcript path, and the Skipped-in line. Changed: maps the supervisor's neutral words to Cursor's own tools instead of translating away from them, drops Bugbot, Automations, cloud agents, and the model rule file, and adds the strongest-model rule for escalation. -->
