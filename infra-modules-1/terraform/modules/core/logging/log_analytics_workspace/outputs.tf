output "id" {
  description = "The id of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.law.id
}

output "name" {
  description = "The name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.law.name
}

output "workspace_id" {
  description = "The workspace id of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.law.workspace_id
}

output "primary_shared_key" {
  description = "The primary shared key of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.law.primary_shared_key
  sensitive   = true
}

output "law_data_collection_rule_id" {
  description = "The id of the Data Collection Rule for Windows VM's"
  value       = azurerm_monitor_data_collection_rule.law_dcr.id
}

output "automation_account_name" {
  description = "The name of the Automation Account"
  value       = azurerm_automation_account.automation_account.name
}