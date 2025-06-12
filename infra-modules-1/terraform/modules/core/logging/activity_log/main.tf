resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  name               = "activity_log_lpdap_shared"
  target_resource_id = "/subscriptions/${var.subscription_id}"

  log_analytics_workspace_id = var.iam_workspace_id

  enabled_log {
    category = "Administrative"
  }
}