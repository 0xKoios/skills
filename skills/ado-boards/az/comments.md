# az: Comments

The az backend for adding, listing, editing, and removing comments.

```bash
# Add
az boards work-item update --id <id> --discussion "<text>" -o json

# List (preview API): each comment has id, text, createdBy.uniqueName, createdDate
az devops invoke --area wit --resource comments --route-parameters project="<project>" workItemId=<id> --api-version 7.1-preview.4 -o json

# Edit (preview API): body file contains {"text": "<new text>"}
az devops invoke --area wit --resource comments --route-parameters project="<project>" workItemId=<id> commentId=<comment id> --http-method PATCH --in-file comment.json --api-version 7.1-preview.4 -o json

# Remove (preview API)
az devops invoke --area wit --resource comments --route-parameters project="<project>" workItemId=<id> commentId=<comment id> --http-method DELETE --api-version 7.1-preview.4 -o json
```

Write `comment.json` to a temp folder and delete it afterwards. In PowerShell, write it without a byte-order mark so `az` can parse it:
`[IO.File]::WriteAllText("$env:TEMP\comment.json", '{"text": "<new text>"}')`
