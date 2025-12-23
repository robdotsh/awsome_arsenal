# Production Planning Team
resource "azuredevops_team" "production_planning" {
  project_id  = azurerm_devops_project.manufacturing.id
  name        = var.production_planning_team_name
  description = var.production_planning_team_description

  tags = merge(var.tags, {
    TeamType    = "ProductionPlanning"
    Environment = "Production"
    ManagedBy   = "TF"
  })
}

resource "azuredevops_team_member" "production_planning_members" {
  for_each = toset(var.member_emails)

  team_id   = azuredevops_team.production_planning.id
  principal = each.value
}
