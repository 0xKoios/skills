# az: Plan my sprint

Commands for the current sprint and my open cards in it.

```bash
# Current sprint of the team (path and dates)
az boards iteration team list --team "<team>" --timeframe current -o json

# My open cards in that sprint
az boards query --wiql "SELECT [System.Id],[System.WorkItemType],[System.Title],[System.State],[System.Tags],[Microsoft.VSTS.Common.Priority],[System.ChangedDate] FROM WorkItems WHERE [System.TeamProject] = @project AND [System.AssignedTo] = @Me AND [System.IterationPath] = '<sprint path>' AND [System.State] NOT IN ('Closed','Removed')" -o json
```

Then `az boards work-item show --expand relations` per card. In `relations[].rel`:

- `System.LinkTypes.Dependency-Reverse` — predecessor (this card waits on it)
- `System.LinkTypes.Dependency-Forward` — successor (it waits on this card)
- `System.LinkTypes.Hierarchy-Reverse` — parent

Linked card ID = last segment of `relations[].url`; read it for state and assignee.
