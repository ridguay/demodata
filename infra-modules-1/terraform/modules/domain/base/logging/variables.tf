variable "name" {
  description = "Log Analytics Workspace instance name"
  type        = string
}

variable "automation_name" {
  description = "Log Analytics Workspace Automation name"
  type        = string
}

variable "data_collection_rule_name" {
  description = "Log Analytics Workspace Data Collection Rule name"
  type        = string
}


variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the resource"
  type        = string
  default     = "West Europe"
}

variable "retention_in_days" {
  description = "Log Analytics Workspace data retention in days\nPossible values: 7 or range between 30 and 730"
  type        = number # Possible values are either 7 (Free Tier only) or range between 30 and 730
}

variable "tags" {
  description = "Tags to assign to the Low Analytics Workspace instance"
  type        = map(string)
  default     = {}
}
