variable "key_vault_location" {
  type        = string
  default     = "West Europe"
  description = "The location of the Key Vault instancs"

  validation {
    condition     = contains(["West Europe"], var.key_vault_location)
    error_message = "Resource location is not allowed. Valid value is West Europe."
  }
}

variable "key_vault_name" {
  description = "Name of the Key Vault instance"
  type        = string # e.g. kv-example

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$", var.key_vault_name))
    error_message = "Key vault name must comply with regex ^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$."
  }

  validation {
    condition     = 3 <= length(var.key_vault_name) && length(var.key_vault_name) <= 24
    error_message = "Key vault name must be between 3 and 24 characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The Resource Group name of the Key Vault instance"
}

variable "key_vault_sku_name" {
  description = "The Name of the SKU used for this Key Vault instance\nPossible values: 'standard', 'premium'"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.key_vault_sku_name)
    error_message = "Allowed values are standard and premium."
  }
}

variable "key_vault_tenant_id" {
  description = "Subscription tenant id for authenticating requests to the key vault."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the Key Vault instance"
  type        = map(string)
  default     = {}
}

variable "key_vault_soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted\nMin: 7, max: 90"
  type        = number
  default     = 90 # e.g. this value can be between 7 and 90 (as default) days."
}

variable "key_vault_enable_purge_protection" {
  description = "Boolean to enable purge protection, which prevents you from deleting soft-deleted vaults and objects"
  type        = bool
  default     = true
}

variable "key_vault_enable_rbac_authorization" {
  description = "Boolean to enable role base access control authorization on Key Vault resource"
  type        = bool
  default     = false
}

variable "key_vault_enable_disk_encryption" {
  description = "Boolean to enable disk encryption on Key Vault instance"
  type        = bool
  default     = false
}

variable "network_control_allowed_subnet_ids" {
  description = "Subnet resource ids which should be able to access the Key Vault"
  type        = list(string)
  default     = null
}

variable "network_control_allowed_ip_rules" {
  description = "(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Storage Account."
  type        = list(string)
  default     = null
}

variable "network_control_allowed_azure_services" {
  description = "Configure Key Vault firewall to bypass the rules and allow Azure services to access"
  type        = bool
  default     = false # Access is disallowed by default
}

variable "private_endpoint_subnet_id" {
  description = "The resource id of the subnet to deploy the private endpoint into"
  type        = string # e.g. /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1"
  default     = ""
}

variable "create_private_endpoint" {
  description = "When true create private endpoint for the Key Vauylt instance"
  type        = bool
  default     = true
}

variable "key_vault_private_endpoint_ip" {
  description = "The private IP address to assign to the private endpoint"
  type        = string
}