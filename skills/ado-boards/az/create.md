# az: Create

Commands for creating cards and linking a parent. HTML description writes on Windows → also `windows.md`.

```bash
# Find a parent by keyword (use 'Feature' when the new card is a User Story)
az boards query --wiql "SELECT [System.Id],[System.Title],[System.State],[System.IterationPath] FROM WorkItems WHERE [System.TeamProject] = @project AND [System.WorkItemType] = 'User Story' AND [System.State] NOT IN ('Closed','Removed') AND [System.Title] CONTAINS '<keyword>'" -o json

# Task (area and sprint from the parent)
az boards work-item create --type Task --title "<title>" --assigned-to "<me>" --area "<parent area>" --iteration "<parent iteration>" --fields "Microsoft.VSTS.Scheduling.OriginalEstimate=<n>" "Microsoft.VSTS.Scheduling.RemainingWork=<n>" -o json

# User Story
az boards work-item create --type "User Story" --title "<title>" --assigned-to "<me>" --area "<area>" --iteration "<iteration>" --description "<html>" --fields "Microsoft.VSTS.Common.AcceptanceCriteria=<html>" -o json

# Parent link: make <new id> a child of <parent id>
az boards work-item relation add --id <new id> --relation-type parent --target-id <parent id> -o json
```
