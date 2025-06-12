resource "azurerm_subscription_policy_assignment" "updatesassessment" {
  name                 = "UpdatesAssessment"
  subscription_id      = local.subscription_resource_id
  policy_definition_id = var.policy_definition_id
  location             = var.location

  identity {
    type = "SystemAssigned"
  }
}