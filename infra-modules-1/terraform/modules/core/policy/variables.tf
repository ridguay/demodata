variable "subscription_id" {
  type        = string
  description = "Subscription ID"
}

variable "location" {
  description = "Location of the resource"
  type        = string
  default     = "West Europe"
}

variable "policy_definition_id" {
  type        = string
  description = "Policy Definition ID to apply"
}
