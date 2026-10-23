# az: Setup

The az backend for skill setup and discovery.

```bash
az --version
az extension show --name azure-devops
az extension add --name azure-devops
az account show --query user.name -o tsv
az devops configure --defaults organization=https://dev.azure.com/<org> project="<project>"
az devops project show --project "<project>" --query capabilities.processTemplate.templateName -o tsv

# Types: states and fields (look for Custom.* and required fields)
az devops invoke --area wit --resource workitemtypes --route-parameters project="<project>" type="User Story" --api-version 7.1 -o json
az devops invoke --area wit --resource workitemtypes --route-parameters project="<project>" type="Task" --api-version 7.1 -o json

# Tags on my cards in the last 90 days (count them from the System.Tags values)
az boards query --wiql "SELECT [System.Id],[System.Tags] FROM WorkItems WHERE [System.TeamProject] = @project AND [System.AssignedTo] = @Me AND [System.ChangedDate] >= @Today - 90" -o json

# Acceptance criteria of recently closed stories in the team's area
az boards query --wiql "SELECT [System.Id],[System.Title],[Microsoft.VSTS.Common.AcceptanceCriteria] FROM WorkItems WHERE [System.TeamProject] = @project AND [System.WorkItemType] = 'User Story' AND [System.State] = 'Closed' AND [System.AreaPath] UNDER '<area path>' ORDER BY [Microsoft.VSTS.Common.ClosedDate] DESC" -o json
```

The last query can return many rows: use the first 10.
