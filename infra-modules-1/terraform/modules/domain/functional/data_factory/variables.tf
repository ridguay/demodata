### Common Variables ###

variable "resource_group_name" {
  description = "The Resource Group name of the Data Factory instance"
  type        = string
}

variable "location" {
  description = "Location of Data Factory instance"
  type        = string
  default     = "West Europe"
}

variable "tags" {
  description = "Tags to assign to the Data Factory instance"
  type        = map(string)
  default     = {}
}

### Data Factory Variables ###

variable "name" {
  description = "Data factory resource name"
  type        = string
}

variable "public_network_enabled" {
  description = "True to make the Data Factory instance visible to the public network"
  type        = bool
  default     = false
}

variable "global_parameters" {
  description = "Specifies the global parameters in ADF"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
  validation {
    condition = length([
      for gp in var.global_parameters : true
      if contains(["Array", "String", "Float", "Int", "Object", "Bool"], gp.type)
    ]) == length(var.global_parameters)
    error_message = "Invalid type! Type should be Array, String, Float, Int, Object or Bool."
  }
}

variable "identity_type" {
  description = "Specifies the identity type of the Data Factory instance\nPossible values: 'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned'"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "Specifies the identity ids of the Data Factory instance\nRequired if 'UserAssigned' or 'SystemAssigned, UserAssigned' is used"
  type        = list(string)
  default     = []
}

variable "private_endpoint_subnet_id" {
  description = "The subnet id to deploy the private endpoint into"
  type        = string
}

variable "private_endpoint_ip" {
  description = "Ip of the private endpoint."
  type        = string
}

variable "git_sync_configuration" {
  description = "Configuration needed to sync the ADF instance to an Azure DevOps repository."
  type = object({
    account_name       = string
    branch_name        = string
    project_name       = string
    repository_name    = string
    root_folder        = string
    tenant_id          = string
    publishing_enabled = bool
  })
  default = null
}

### Key Vault Variables ###

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
variable "key_vault_network_control_allowed_subnet_ids" {
  description = "Subnet resource ids which should be able to access the Key Vault"
  type        = list(string)
  default     = null
}

variable "key_vault_network_control_allowed_ip_rules" {
  description = "(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Storage Account."
  type        = list(string)
  default     = null
}

variable "key_vault_network_control_allowed_azure_services" {
  description = "Configure Key Vault firewall to bypass the rules and allow Azure services to access"
  type        = bool
  default     = false # Access is disallowed by default
}

variable "key_vault_private_endpoint_subnet_id" {
  description = "The resource id of the subnet to deploy the private endpoint into"
  type        = string # e.g. /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1"
  default     = ""
}

variable "key_vault_create_private_endpoint" {
  description = "When true create private endpoint for the Key Vault instance"
  type        = bool
  default     = true
}

### Self-Hosted Integration Runtime ###

variable "shir_name" {
  description = "Self Hosted Integration Runtime name"
  type        = string
}

### Azure Hosted Integration Runtime ###

variable "storage_account_id" {
  description = "The ID of the storage account to which an Azure Managed Integration Runtime should be able to connect"
  type        = string
  default     = null
}

variable "managed_private_endpoint_name" {
  description = "The name of the managed private endpoint used to connect an Azure Managed Integration Runtime to an Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_integration_runtime_name" {
  description = "The name for the Azure Managed Integration Runtime"
  type        = string
  default     = ""
}
