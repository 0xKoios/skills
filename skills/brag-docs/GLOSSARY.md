# Brag docs

Language for the living record of someone’s work impact, and the skill that maintains it.

## Language

**Brag document**:
The durable record of accomplishments (usually one file or page per year). The default home is a local markdown file.
_Avoid_: Status report, resume, journal dump, brag sheet (as the skill name)

**Entry**:
One accomplishment written as action → result → evidence.
_Avoid_: Bullet with no impact, activity-only line item

**Evidence**:
Proof that backs an entry (metric, PR/doc link, observable outcome, or qualitative context). Missing proof is marked `(evidence needed)`.
_Avoid_: Fabricated metric, vibe

**Store**:
Where or how this run delivers entries: `markdown` (local file), `notion` (page append), or `chat-only` (pasteable markdown, no persistence).
_Avoid_: Assuming every Store writes to disk

**brag-setup**:
The workflow that writes user preferences to config.
_Avoid_: configure (as the command name)

**brag-capture**:
The workflow that turns fresh notes or a short interview into one or more entries.
_Avoid_: log, add (as the command name)

**brag-backfill**:
The workflow that reconstructs entries for a time range, optionally scanning dig sources.
_Avoid_: recall, rebuild (as the command name)

**Dig**:
Optional scan of external signals (git, GitHub PRs, boards) to propose backfill candidates. Never required for capture.
_Avoid_: Required integration, auto-save from tools
