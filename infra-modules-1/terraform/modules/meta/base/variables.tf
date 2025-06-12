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

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "meta_resource_group_name" {
  description = "Name of the Meta resoruce group"
  type        = string
}

variable "virtual_network_data" {
  description = "Virtual network data"
  type = object({
    resource_group_name = string
    name                = string
  })
}

### Module Specific Vars ###
variable "tfstate_subnet_vars" {
  type = object({
    location              = optional(string, "West Europe")
    tags                  = optional(map(string), {})
    subnet_name           = string
    subnet_address_prefix = string
  })
}

variable "services_subnet_vars" {
  type = object({
    location              = optional(string, "West Europe")
    tags                  = optional(map(string), {})
    subnet_name           = string
    subnet_address_prefix = string
  })
}

variable "tfstate_storage_vars" {
  type = object({
    location                         = optional(string, "West Europe")
    tags                             = optional(map(string), {})
    deploy_storage_account           = optional(bool, false)
    storage_account_name             = string
    storage_account_replication_type = optional(string, "ZRS")
    storage_account_account_tier     = optional(string, "Standard")
    shared_access_key_enabled        = optional(bool, false)
    public_network_access_enabled    = optional(bool, true)
    default_to_oauth_authentication  = optional(bool, true)
    allow_nested_items_to_be_public  = optional(bool, false)
    delete_policy = optional(object({
      blob_delete_retention      = string, # Specifies the number of days that the blob should be retained, between 1 and 365 days.
      container_delete_retention = string  # Specifies the number of days that the container should be retained, between 1 and 365 days.
    }), null)
    enabled_from_all_networks          = optional(string, "Deny")
    network_rules_bypasses             = optional(list(string), ["Logging", "Metrics", "AzureServices"])
    network_control_allowed_subnet_ids = optional(list(string), null)
    network_control_allowed_ip_rules   = optional(list(string), null)
    private_link_access_tenant_id      = optional(string, null)
    private_link_access_resource_id    = optional(string, null)
    blob_private_endpoint_ip           = optional(string, null)
    dfs_private_endpoint_ip            = optional(string, null)
    container_names                    = list(string)
    container_access                   = optional(string, "private")
  })
}

variable "utility_storage_vars" {
  type = object({
    location                         = optional(string, "West Europe")
    tags                             = optional(map(string), {})
    deploy_storage_account           = optional(bool, true)
    storage_account_name             = string
    storage_account_replication_type = optional(string, "ZRS")
    storage_account_account_tier     = optional(string, "Standard")
    shared_access_key_enabled        = optional(bool, false)
    public_network_access_enabled    = optional(bool, true)
    default_to_oauth_authentication  = optional(bool, true)
    allow_nested_items_to_be_public  = optional(bool, false)
    delete_policy = optional(object({
      blob_delete_retention      = string, # Specifies the number of days that the blob should be retained, between 1 and 365 days.
      container_delete_retention = string  # Specifies the number of days that the container should be retained, between 1 and 365 days.
    }), null)
    enabled_from_all_networks          = optional(string, "Deny")
    network_rules_bypasses             = optional(list(string), ["Logging", "Metrics", "AzureServices"])
    network_control_allowed_subnet_ids = optional(list(string), null)
    network_control_allowed_ip_rules   = optional(list(string), null)
    private_link_access_tenant_id      = optional(string, null)
    private_link_access_resource_id    = optional(string, null)
    blob_private_endpoint_ip           = optional(string, null)
    dfs_private_endpoint_ip            = optional(string, null)
    container_names                    = list(string)
    container_access                   = optional(string, "private")
  })
}

variable "logging_storage_vars" {
  type = object({
    location                         = optional(string, "West Europe")
    tags                             = optional(map(string), {})
    deploy_storage_account           = optional(bool, true)
    storage_account_name             = string
    storage_account_replication_type = optional(string, "ZRS")
    storage_account_account_tier     = optional(string, "Standard")
    shared_access_key_enabled        = optional(bool, false)
    public_network_access_enabled    = optional(bool, true)
    default_to_oauth_authentication  = optional(bool, true)
    allow_nested_items_to_be_public  = optional(bool, false)
    delete_policy = optional(object({
      blob_delete_retention      = string, # Specifies the number of days that the blob should be retained, between 1 and 365 days.
      container_delete_retention = string  # Specifies the number of days that the container should be retained, between 1 and 365 days.
    }), null)
    enabled_from_all_networks          = optional(string, "Deny")
    network_rules_bypasses             = optional(list(string), ["Logging", "Metrics", "AzureServices"])
    network_control_allowed_subnet_ids = optional(list(string), null)
    network_control_allowed_ip_rules   = optional(list(string), null)
    private_link_access_tenant_id      = optional(string, null)
    private_link_access_resource_id    = optional(string, null)
    blob_private_endpoint_ip           = optional(string, null)
    dfs_private_endpoint_ip            = optional(string, null)
    container_names                    = list(string)
    container_access                   = optional(string, "private")
  })
}

variable "key_vault_iam_vars" {
  type = object({
    name                                   = string
    sku_name                               = optional(string, "standard")
    tags                                   = optional(map(string), {})
    soft_delete_retention_days             = optional(number, 90)
    enable_purge_protection                = optional(bool, true)
    enable_rbac_authorization              = optional(bool, true)
    enable_disk_encryption                 = optional(bool, false)
    network_control_allowed_subnet_ids     = optional(list(string), null)
    network_control_allowed_ip_rules       = optional(list(string), null)
    network_control_allowed_azure_services = optional(bool, false)
    create_private_endpoint                = optional(bool, true)
    private_endpoint_ip                    = string
  })
}
variable "key_vault_envs_vars" {
  type = object({
    name                                   = string
    sku_name                               = optional(string, "standard")
    tags                                   = optional(map(string), {})
    soft_delete_retention_days             = optional(number, 90)
    enable_purge_protection                = optional(bool, true)
    enable_rbac_authorization              = optional(bool, true)
    enable_disk_encryption                 = optional(bool, false)
    network_control_allowed_subnet_ids     = optional(list(string), null)
    network_control_allowed_ip_rules       = optional(list(string), null)
    network_control_allowed_azure_services = optional(bool, false)
    create_private_endpoint                = optional(bool, true)
    private_endpoint_ip                    = string
  })
}

variable "logging_vars" {
  type = object({
    name                      = string
    automation_name           = string
    data_collection_rule_name = string
    retention_in_days         = string
    tags                      = optional(map(string), {})
    subscription_id           = string
  })
}

variable "databricks_vars" {
  type = object({
    access_connector_name = string
    access_connector_tags = optional(map(string), {})

    subnet_name                          = string
    subnet_tags                          = optional(map(string), {})
    subnet_private_subnet_address_prefix = string
    subnet_public_subnet_address_prefix  = string

    workspace_managed_resource_group_name = string
    workspace_name                        = string
    workspace_tags                        = optional(map(string), {})
    workspace_secure_cluster_connectivity = optional(bool, true) # Read more at https://docs.microsoft.com/en-us/azure/databricks/security/secure-cluster-connectivity"
    workspace_private_endpoint_ip         = string
    workspace_vnet_resource_group_name    = string
  })
}

variable "gallery_name" {
  description = "The name of the gallery for the VM Apps. Not wrapped inside a object as for other submodules, because it's the only module-specific var."
  type        = string
}