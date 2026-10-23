# az: Description and acceptance criteria

Command for writing description and AC fields. HTML on Windows → also `windows.md`.

```bash
az boards work-item update --id <id> --description "<p>...</p>" --fields "Microsoft.VSTS.Common.AcceptanceCriteria=<ul><li>...</li></ul>" -o json
```

Acceptance criteria is long-text: in WIQL use `IS EMPTY` / `IS NOT EMPTY`, not `= ''`.
