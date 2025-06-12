resource "azurerm_monitor_diagnostic_setting" "ds" {
  count = var.log_analytics_destination_type == null ? 0 : 1
  name  = var.diagnostic_setting_name

  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = var.enabled_logs

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "ds_no_destination_type" {
  count                      = var.log_analytics_destination_type == null ? 1 : 0
  name                       = var.diagnostic_setting_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = var.enabled_logs

    content {
      category = enabled_log.value

      #      retention_policy {
      #        enabled = true
      #        days    = 90
      #      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
    }
  }
}