resource "azurerm_log_analytics_workspace" "law" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"

  retention_in_days          = var.retention_in_days
  tags                       = var.tags
  internet_ingestion_enabled = true
  internet_query_enabled     = true
}

resource "azurerm_automation_account" "automation_account" {
  name                          = var.automation_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku_name                      = "Basic"
  public_network_access_enabled = false
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
  depends_on = [
    azurerm_log_analytics_workspace.law
  ]
}

# Add role assignments for AA identity to resource group
resource "azurerm_role_assignment" "role_assignment" {
  count = length(local.role_assignments)

  scope                = local.role_assignments[count.index].resource_id
  principal_id         = local.role_assignments[count.index].principal_id
  role_definition_name = local.role_assignments[count.index].role
  depends_on = [
    azurerm_automation_account.automation_account
  ]
}

resource "azurerm_log_analytics_linked_service" "linked_service" {
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.law.id
  read_access_id      = azurerm_automation_account.automation_account.id
  depends_on = [
    azurerm_log_analytics_workspace.law
  ]
}

resource "azurerm_log_analytics_solution" "solutions" {
  for_each = toset(["Security", "SecurityInsights", "AgentHealthAssessment", "AzureActivity", "AzureAutomation",
  "ChangeTracking", "VMInsights"])
  solution_name         = each.key
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = var.name
  tags                  = var.tags

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/${each.key}"
  }
}

resource "azurerm_monitor_data_collection_rule" "law_dcr" {
  name                = var.data_collection_rule_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  depends_on = [
    azurerm_log_analytics_workspace.law
  ]

  identity {
    type = "SystemAssigned"
  }

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
      name                  = var.name
    }
  }

  data_flow {
    streams      = ["Microsoft-WindowsEvent"]
    destinations = [var.name]
  }

  data_sources {

    windows_event_log {
      name    = "eventLogsDataSource"
      streams = ["Microsoft-WindowsEvent"]
      x_path_queries = [
        "Application!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=0 or Level=5)]]",
        "Security!*[System[(band(Keywords,13510798882111488))]]",
        "System!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=0)]]"
      ]
    }

    extension {
      name = "ChangeTracking-Windows"
      streams = ["Microsoft-ConfigurationChange",
        "Microsoft-ConfigurationChangeV2",
      "Microsoft-ConfigurationData"]
      extension_name = "ChangeTracking-Windows"
    }
  }
}

