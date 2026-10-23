# az: Description and acceptance criteria

The az backend for writing description and acceptance criteria fields.

```bash
az boards work-item update --id <id> --description "<p>...</p>" --fields "Microsoft.VSTS.Common.AcceptanceCriteria=<ul><li>...</li></ul>" -o json
```

Acceptance criteria is a long-text field: in WIQL use `IS EMPTY` / `IS NOT EMPTY`, not `= ''`.

When writing HTML on Windows, also read `windows.md`.
