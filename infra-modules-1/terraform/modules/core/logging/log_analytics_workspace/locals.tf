locals {
  role_assignments = [
    {
      resource_id  = data.azurerm_resource_group.rg.id
      principal_id = azurerm_automation_account.automation_account.identity[0].principal_id
      role         = "Reader"
    },
    {
      resource_id  = data.azurerm_resource_group.rg.id
      principal_id = azurerm_automation_account.automation_account.identity[0].principal_id
      role         = "DevTest Labs User"
    }
  ]
}