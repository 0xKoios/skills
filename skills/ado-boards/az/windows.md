# az: Windows and PowerShell notes

Load only when writing HTML description/AC, or when PowerShell quoting fails.

- Paths: PowerShell `"Project\Sprint 12"`; bash `"Project\\Sprint 12"`.
- Long commands: PowerShell backtick, bash `\`, or one line.
- `az` runs through `az.cmd`, so `<`, `>`, `&`, `|` inside HTML can mangle even when quoted. Broken HTML on read-back → write HTML to a temp file and pass `--description "@desc.html"` (`@` = load from file). Delete the temp file afterwards.
