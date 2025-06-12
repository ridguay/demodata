variable "resource_group_name" {
  description = "The name of the meta resource group"
  type        = string
}

variable "location" {
  description = "The location/region of the meta resource group"
  type        = string
  default     = "West Europe"
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "deploy_storage_account" {
  description = "Boolean to decide whether or not to deploy a storage account."
  type        = bool
  default     = true
}

variable "storage_account_name" {
  description = "The name of the storage account that needs to be deployed. If empty, there already exists a storage account."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9]+$", var.storage_account_name)) || length(var.storage_account_name) < 3 || length(var.storage_account_name) > 24
    error_message = "The name of the storage account must be between 3 and 24 characters, regex [a-z0-9]+$"
  }
}

variable "storage_account_replication_type" {
  type        = string
  default     = "ZRS"
  description = "Defines the type of replication to use for the Storage Account instance\nPossible values: {LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS}"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_account_replication_type)
    error_message = "The replication type of the Storage Account instance must be LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
  }
}

variable "storage_account_account_tier" {
  description = "The used tier for the Storage Account instance\nExample: {Standard,Premium}"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_account_tier)
    error_message = "The tier for the Storage Account instance must be Standard or Premium."
  }
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key"
  type        = bool
  default     = false
}

variable "default_to_oauth_authentication" {
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account"
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Allow public access on the storage account"
  type        = bool
  default     = false
}

variable "delete_policy" {
  description = "Specifies the number of days that the blob/container should be retained"
  type = object({
    blob_delete_retention      = string, # Specifies the number of days that the blob should be retained, between 1 and 365 days.
    container_delete_retention = string  # Specifies the number of days that the container should be retained, between 1 and 365 days.
  })
  default = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled"
  default     = true
}

variable "enabled_from_all_networks" {
  type        = string
  default     = "Deny"
  description = "Enable public network access for the storage account, (you also need to put var.public_network_access_enabled to `true`). This is not allowed, only when you have an approval of your BSO.(https://making.nn.nl/spaces/cloud/azure-cloud-platform/platform/security-compliance/azure-policies/exemptions-on-enforced-azure-policies/)"

  validation {
    condition     = contains(["allow", "deny"], lower(var.enabled_from_all_networks))
    error_message = "Valid values for var: enabled_from_all_networks are (Allow or Deny)."
  }
}

variable "network_rules_bypasses" {
  description = "Special network rules for Azure/logging services accessing ADLS."
  type        = list(string)
  default     = ["Logging", "Metrics", "AzureServices"]

  validation {
    condition = alltrue([
      for rule in var.network_rules_bypasses : contains(["Logging", "Metrics", "AzureServices"], rule)
    ])
    error_message = "Invalid input. Each item in list should be: Logging, Metrics or AzureServices."
  }
}

variable "network_control_allowed_subnet_ids" {
  description = "One or more subnet resource ids which should be able to access this Storage Account instance"
  type        = list(string)
  default     = null
}

variable "network_control_allowed_ip_rules" {
  description = "One or more ip addresses, or CIDR Blocks which should be able to access the Storage Account instance"
  type        = list(string)
  default     = null
}

variable "private_link_access_tenant_id" {
  description = "Tenant id to use for private link access to storage account"
  type        = string
  default     = null
}

variable "private_link_access_resource_id" {
  description = "Resource id of resource to allow private link access to storage account"
  type        = string
  default     = null
}

variable "private_endpoint_subnet_id" {
  description = "The ID of the subnet in which the private endpoint should be"
  type        = string
}

variable "blob_private_endpoint_ip" {
  description = "The IP for the blob-targeted private endpoint"
  type        = string
  default     = null
}

variable "dfs_private_endpoint_ip" {
  description = "The IP for the dfs-targeted private endpoint"
  type        = string
  default     = null
}

variable "container_names" {
  description = "The names of the storage containers"
  type        = list(string)
}

variable "container_access" {
  description = "Type of access for the container"
  type        = string
  default     = "private"
}
