# az: Comments

Commands for add, list, edit, remove.

```bash
# Add
az boards work-item update --id <id> --discussion "<text>" -o json

# List (preview API): id, text, createdBy.uniqueName, createdDate
az devops invoke --area wit --resource comments --route-parameters project="<project>" workItemId=<id> --api-version 7.1-preview.4 -o json

# Edit (preview API): body file is {"text": "<new text>"}
az devops invoke --area wit --resource comments --route-parameters project="<project>" workItemId=<id> commentId=<comment id> --http-method PATCH --in-file comment.json --api-version 7.1-preview.4 -o json

# Remove (preview API)
az devops invoke --area wit --resource comments --route-parameters project="<project>" workItemId=<id> commentId=<comment id> --http-method DELETE --api-version 7.1-preview.4 -o json
```

Write `comment.json` to a temp folder; delete afterwards. PowerShell without BOM so `az` can parse it:

`[IO.File]::WriteAllText("$env:TEMP\comment.json", '{"text": "<new text>"}')`
