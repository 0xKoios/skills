# az: Windows and PowerShell notes

Load only when writing HTML descriptions/acceptance criteria or when PowerShell quoting fails.

- Backslashes in paths need no escaping in PowerShell: `"Project\Sprint 12"`. In bash, use `"Project\\Sprint 12"`.
- Split long commands with a backtick in PowerShell, `\` in bash, or keep them on one line.
- `az` runs through `az.cmd`, so `<`, `>`, `&` and `|` inside values (HTML in descriptions) can be mangled even when quoted. If a read-back shows broken HTML, write the HTML to a temp file and pass `--description "@desc.html"` (Azure CLI loads a value from a file with the `@` prefix). Delete the temp file afterwards.
