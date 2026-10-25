# Eval cases

Each skill keeps its cases in `skills/<skill>/evals/evals.json`. `scripts/eval-skill.sh` runs them, and `scripts/check-skill.sh` validates them.

## Schema

```json
{
  "skill_name": "supervisor",
  "install": ["principle-*"],
  "evals": [
    {
      "id": "bug-fix-skips-questions",
      "prompt": "/supervisor orders_daily.sql shows blank customer_id since Monday, fix it",
      "should_trigger": true,
      "expected_output": "Goes straight to a failing repro on orders_daily.sql with no questioning phase.",
      "files": ["evals/files/orders_daily.sql"],
      "checks": [
        { "type": "output_matches", "pattern": "orders_daily\\.sql" },
        { "type": "output_not_matches", "pattern": "Gate: questions done" }
      ],
      "assertions": [
        "Builds or proposes a failing repro command before proposing a fix."
      ]
    }
  ]
}
```

- **`skill_name`:** must equal the skill's folder name.
- **`install`** (optional): extra skill folders to install beside the skill, as globs under `skills/`. Use it when the skill reads other skills, such as the supervisor reading its principle leaves.
- **`id`:** unique in the file, kebab-case, naming the behavior. `--case <id>` runs one case.
- **`prompt`:** the exact message the agent gets.
- **`should_trigger`** (optional): whether the skill should fire on this prompt.
- **`expected_output`:** one line for the human reader. The runner doesn't grade it.
- **`files`** (optional): paths relative to the skill folder, usually under `evals/files/`. Each is copied into the trial's empty workspace under its base name.
- **`checks`:** each has `type` (`output_matches` or `output_not_matches`) and a `pattern` in POSIX ERE, run with `grep -E` over the agent's reply. ERE has no `(?i)`, so write case variants as `[Dd]one`. Escape backslashes for JSON.
- **`assertions`:** plain-language criteria a model grader judges against the reply. Each must be checkable from the reply alone, because the grader sees nothing else.

A case needs at least one check or assertion, or check-skill fails.

## Writing a good case

- **Realistic prompts with no testing words.** Write it the way the user types: terse, with real file names and real stakes. "Test", "eval", or "scenario" in the prompt tells the agent it's being watched and changes what it does.
- **Built from a real mistake when there is one.** A correction's case uses the prompt that actually went wrong (`corrections.md`).
- **One behavior per case,** so a failure names what broke.
- **Cheap checks before assertions.** The runner applies regex checks first and calls the grader only when they pass. A regex is free and deterministic, and the grader costs a model call and can disagree with itself. Put anything a pattern can catch in `checks`, and keep `assertions` for judgment.
- **Patterns that can't pass by accident.** Match something only the right behavior produces, such as a command name or a refusal, not a common word.
- **Near-miss `should_trigger: false` cases only for auto-invocable skills.** A near miss is a prompt that sounds close but shouldn't fire the skill, and its checks confirm the skill's behavior is absent. Skills with `disable-model-invocation: true` (the supervisor and every principle leaf) never auto-fire, so their cases invoke them explicitly, as `/supervisor ...` or `/principle-<name> ...`, and test behavior only.

## Running

```bash
scripts/eval-skill.sh <skill> <agent> [--case <id>] [--trials N] [--baseline]
```

Each trial runs in a fresh temp folder. A case passes when a majority of its trials pass. `--baseline` also runs each case without the skill installed.

## Retiring a case

When a case still passes with `--baseline`, the skill isn't what makes it pass. Propose retiring it in one line, with the baseline result as evidence. Never delete it yourself. Removing a case is an edit like any other, so it goes through the approval gate in `corrections.md`.
