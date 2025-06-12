variable "diagnostic_setting_name" {
  description = "Name of the diagnostic setting"
  type        = string
  default     = "NNDAP_log_analytics"
}

variable "target_resource_id" {
  description = "Id of the target instance to add the diagnostic settings configuration to"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Id of the log analytics workspace"
  type        = string
}

variable "log_analytics_destination_type" {
  description = "Type of the log analytics workspace"
  type        = string
  default     = null
}

variable "enabled_logs" {
  description = "Configuration of the logs"
  type        = list(string)
  default     = []
}

variable "metrics" {
  description = "Configuration of the metrics"
  type = list(object({
    category = string
    enabled  = bool
  }))
  default = []
}