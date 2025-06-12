### Generic Vars ###

variable "tenant_id" {
  description = "Id of the tenant to deploy the platform to."
  type        = string
}

variable "location" {
  description = "Region to deploy the platform to."
  type        = string
  default     = "West Europe"
}

### Module Specific Vars ###
variable "resource_group_vars" {
  type = object({
    name = string
    tags = optional(map(string), {})
  })
}

variable "services_subnet_vars" {
  type = object({
    subnet_name           = string
    subnet_address_prefix = string
    virtual_network_data = object({
      resource_group_name = string
      name                = string
    })
  })
}

variable "storage_vars" {
  type = object({
    name                               = string
    tags                               = optional(map(string), {})
    storage_account_extra_tags         = optional(map(string), {})
    account_tier                       = optional(string, "Standard")
    replication_type                   = optional(string, "ZRS")
    network_control_allowed_subnet_ids = optional(list(string), null)
    network_control_allowed_ip_rules   = optional(list(string), null)
    configure_default_network_rules    = optional(bool, true)
    add_private_link_access            = optional(bool, false)
    network_rules_bypasses             = optional(list(string), ["Logging", "Metrics", "AzureServices"])
    delete_policy = optional(object({
      blob_delete_retention      = string
      container_delete_retention = string
    }), null)
    customer_managed_key = optional(object({
      datalake_key_vault_id   = string
      datalake_key_vault_name = string
      key_name                = string
    }), null)
    dfs_private_endpoint_ip  = string
    blob_private_endpoint_ip = string
    storage_management_policy = optional(
      object({
        move_to_cool_after_days = number
      }),
      {
        move_to_cool_after_days = 304
      }
    )
    container_names                 = list(string)
    shared_access_key_enabled       = optional(bool, false)
    default_to_oauth_authentication = optional(bool, true)
  })
}

variable "resource_group_role_assignment_vars" {
  type = object({
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "storage_role_assignment_vars" {
  type = object({
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}
