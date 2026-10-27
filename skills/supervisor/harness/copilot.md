# Supervisor in GitHub Copilot

The supervisor and its playbooks use neutral words. Read this file once per session, then map each neutral word with the lists below. Copilot runs in two places, VS Code agent mode and the Copilot CLI, and some tools exist in only one. Never call a tool the session doesn't list. If a mapping is missing, drop it and say so in one line.

## Tools

- **Spawn a subagent:**
  - VS Code: the `runSubagent` tool (`#agent/runSubagent`, labeled Run Subagent in Configure Tools). It exists only when enabled for the session. A prompt file or custom agent enables it by listing the `agent` tool set under `tools`.
  - CLI: `/fleet` for parallel work, when the session offers it.
  - Neither available: run the steps one after another in this chat. That's not a failure.
- **Ask the user:**
  - VS Code: the `askQuestions` tool (`#vscode/askQuestions`) when listed.
  - CLI: ask in plain text as the last line of the reply. With `--no-ask-user` there's no ask tool, so plain text is the only way.
- **Open a todo list:**
  - VS Code: the `todos` tool (`#todos`) when listed.
  - CLI or no todo tool: keep the list in the reply and update it at each step.
- **Search and shell:** use the tools the session lists. Shell commands run only when the session allows them.

## Strongest model

For model escalation:

- **VS Code:** pass the strongest model the session offers as the model parameter to `runSubagent`, or ask the user to switch the model picker. A model above the main model's cost tier is refused, and the refusal lists what's allowed, so pick the strongest from that list.
- **CLI:** rerun with `--model <strongest>` or `/model`, choosing from the models the CLI lists.

If no model can be picked from inside the session, skip straight to the user and say so in one line. Pin no model anywhere else.

## Paths

- **Skills:** `.github/skills/<name>/` in a project, `~/.copilot/skills/<name>/` for the user.
- **Agent instructions:** **AGENTS.md**, or **.github/copilot-instructions.md** when the repo uses that instead.
- **Transcripts (for supervisor-reflect):**
  - CLI: session folders under `~/.copilot/session-state/`. List the folder and take the newest session.
  - VS Code: chat sessions live in VS Code's workspace storage, which has no stable documented path. When you can't find the transcript, ask the user to export the chat and give you the file.

## Steps Copilot can't do

When a step needs something this Copilot session lacks, write one line in the reply, `Skipped in Copilot: <step>. <reason>.`, and go on to the next step. Don't stop, ask, or retry. When a later step needs what the skipped step would have made, leave a placeholder and name it in the line.

<!-- Adapted from docs/harness/claude-code.md (cursor/plugins pstack, MIT, Lauren Tan). Took: the adapter shape, read-once framing, plain-text fallback for asking, todo fallback, and the Skipped-in line. Changed: maps the supervisor's neutral words to VS Code agent-mode and Copilot CLI tools, adds runSubagent enablement and its cost-tier refusal, the CLI model flag, Copilot skills and transcript paths, and drops everything Cursor-specific. -->
