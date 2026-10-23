# az: My cards

The az backend for viewing, moving, logging time, and closing the user's cards.

```bash
# Open cards assigned to me
az boards query --wiql "SELECT [System.Id],[System.WorkItemType],[System.Title],[System.State],[System.IterationPath],[System.Tags],[Microsoft.VSTS.Scheduling.RemainingWork] FROM WorkItems WHERE [System.TeamProject] = @project AND [System.AssignedTo] = @Me AND [System.State] NOT IN ('Closed','Removed') ORDER BY [System.State]" -o json

# Cards I changed in a range (here: since yesterday)
az boards query --wiql "SELECT [System.Id],[System.Title],[System.State] FROM WorkItems WHERE [System.TeamProject] = @project AND [System.ChangedBy] = @Me AND [System.ChangedDate] >= @Today - 1" -o json

# One card with its links
az boards work-item show --id <id> --expand relations -o json

# Move
az boards work-item update --id <id> --state "<state>" -o json

# Log time: values are the new totals in the config unit, not deltas
az boards work-item update --id <id> --fields "Microsoft.VSTS.Scheduling.CompletedWork=<total>" "Microsoft.VSTS.Scheduling.RemainingWork=<total>" -o json

# Impact comment after closing
az boards work-item update --id <id> --discussion "Impact: <text>" -o json
```
