## Generic Vars ##
variable "resource_group_name" {
  type        = string
  description = "The Resource Group name"
}

variable "tags" {
  description = "Tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "The location to deploy all resources to"
  type        = string
  default     = "West Europe"
}

variable "meta_key_vault_name" {
  description = "The name of the meta key vault"
  type        = string
}

variable "meta_resource_group" {
  description = "The name of the meta resource group"
  type        = string
}

variable "artifactory_password_secret_name" {
  description = "The name of the Artifactory secret inside the meta key vault. This will not yet be used but in the future will be required for the Databricks init script."
  type        = string
}

## Key Vault Specific Vars ###
variable "key_vault_vars" {
  type = object({
    name                                   = string
    sku_name                               = optional(string, "standard")
    tenant_id                              = string
    soft_delete_retention_days             = optional(number, 90)
    enable_purge_protection                = optional(bool, true)
    enable_rbac_authorization              = optional(bool, false)
    enable_disk_encryption                 = optional(bool, false)
    network_control_allowed_subnet_ids     = optional(list(string), null)
    network_control_allowed_ip_rules       = optional(list(string), null)
    network_control_allowed_azure_services = optional(bool, false)
    private_endpoint_subnet_id             = optional(string, "")
    create_private_endpoint                = optional(bool, true)
    key_vault_private_endpoint_ip          = optional(string, "")
  })
  default = null
}

### Data Factory Specific Vars ###
variable "data_factory_vars" {
  type = list(object({
    # Data Factory Instance
    name                   = string
    public_network_enabled = optional(bool, false)
    global_parameters = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity_type              = optional(string, "SystemAssigned")
    identity_ids               = optional(list(string), [])
    private_endpoint_subnet_id = string
    private_endpoint_ip        = string
    git_sync_configuration = optional(object({
      account_name       = string
      branch_name        = string
      project_name       = string
      repository_name    = string
      root_folder        = string
      tenant_id          = string
      publishing_enabled = bool
    }), null)

    # Key Vault SHIR
    key_vault_name                                   = string
    key_vault_sku_name                               = optional(string, "standard")
    key_vault_tenant_id                              = string
    key_vault_soft_delete_retention_days             = optional(number, 90)
    key_vault_enable_purge_protection                = optional(bool, true)
    key_vault_enable_rbac_authorization              = optional(bool, false)
    key_vault_enable_disk_encryption                 = optional(bool, false)
    key_vault_network_control_allowed_subnet_ids     = optional(list(string), null)
    key_vault_network_control_allowed_ip_rules       = optional(list(string), null)
    key_vault_network_control_allowed_azure_services = optional(bool, false)
    key_vault_private_endpoint_subnet_id             = optional(string, "")
    key_vault_create_private_endpoint                = optional(bool, true)

    # Self-Hosted Integration Runtime
    shir_name = string

    # Azure Hosted Integration Runtime
    storage_account_id             = optional(string, null)
    managed_private_endpoint_name  = optional(string, "")
    azure_integration_runtime_name = optional(string, "")
  }))
  default = []
}

variable "virtual_machine_vars" {
  type = list(object({
    # Virtual Machine
    virtual_machine_name_prefix                  = string
    virtual_machine_private_ip_addresses         = list(string)
    virtual_machine_size                         = optional(string, "Standard_D4_v4")
    virtual_machine_os_disk_storage_account_type = optional(string, "StandardSSD_LRS")
    virtual_machine_os_disk_size_gb              = optional(number, 127)
    virtual_machine_timezone                     = optional(string, "W. Europe Standard Time")
    virtual_machine_subnet_id                    = string
    virtual_machine_accelerated_networking       = optional(bool, false)
    virtual_machine_application_ids              = optional(list(string), [])

    # VM Extensions and Applications
    monitoring_agent_config = object({
      log_analytics_workspace_workspace_id = string
      log_analytics_workspace_auth_key     = string
    })
    diagnostics_storage_account_name = optional(string, null)
    law_data_collection_rule_id      = optional(string, null)
    vm_patch = object({
      schedule_name = string #"Name of the schedule"
      start_time    = string #"Start time of the schedule"
      start_date    = string #"Start date of the schedule"
      recur_every   = string #"Recurrence interval"
      duration      = string #"Duration of the patching"
    })
    # virtual_machine_application_ids = list(string)
  }))
  default = null
}

variable "adf_infra_components_vars" {
  type = object({
    # Databricks Linked Service
    databricks_workspace_url = string
    databricks_workspace_id  = string
    pool_id                  = optional(string, null)
    cluster_spark_version    = optional(string, "10.4.x-scala2.12")

    # Key Vault Linked Service Variables
    key_vault_id = string

    # Run SQL Query Pipeline Variables
    notebook_path = string

    # Start Stop VM Pipeline Variables
    subscription_id = string
    # virtual_machine_name = string

    # Storage Connection Variables
    storage_account_primary_dfs_endpoint = string
    dataset_config = list(object({
      dataset_name      = string
      container_name    = string
      file_type         = string
      compression_codec = string
      level             = optional(string)
    }))
  })
  default = null
}

variable "databricks_functional_vars" {
  type = object({
    # Workspace Config
    workspace_config_nn_pypi_index_url          = optional(string, "https://artifactory.insim.biz/artifactory/api/pypi/nn-pypi/simple")    # If you run into authentication issues, please the same token for both indices. It's likely that the packaged pip version is out of date. Multi-credential support is available as of pip 21.2 https://github.com/pypa/pip/pull/10033
    workspace_config_nn_customer_pypi_index_url = optional(string, "https://artifactory.insim.biz/artifactory/api/pypi/nndap-pypi/simple") # If you run into authentication issues, please use the same token for both indices. It's likely that the packaged pip version is out of date. Multi-credential support is available as of pip 21.2 https://github.com/pypa/pip/pull/10033
    workspace_config_kafka_secret_name          = string

    # UC enabled
    cluster_uc_enabled = optional(bool, true)

    # Legacy Clusters enabled
    legacy_clusters_enabled = optional(bool, true)

    # Databricks Asset Bundles
    workspace_url = optional(string, "")
    env_domain    = optional(string, "")

    # Notebook Mounting Secrets
    notebook_mounting_secret_scope = string
    notebook_mounting_secrets      = map(string)

    # Variables for Legacy Clusters
    legacy_cluster_names               = optional(list(string), [])
    legacy_user_specific_cluster_names = optional(list(string), [])

    # Variables for Primary Cluster(s)
    cluster_names = list(string)
    cluster_config = object({
      legacy_spark_version_id     = optional(string, "12.2.x-scala2.12")
      spark_version_id            = optional(string, "15.4.x-scala2.12")
      runtime_engine              = optional(string, "PHOTON")
      node_type_id                = optional(string, "Standard_D4ads_v5")
      autoterminate_after_minutes = optional(number, 120)
      tags                        = optional(map(string), {})
      minimum_workers             = optional(number, 2)
      maximum_workers             = optional(number, 8)
      extra_spark_configuration   = optional(map(string), {})
    })
    cluster_pypi_packages = optional(list(string), [])

    cluster_unity_catalog_volume_name                   = string
    cluster_unity_catalog_volume_storage_account_name   = string
    cluster_unity_catalog_volume_storage_container_name = string

    # Unity catalog volume / schema Entra group name, service principal name
    unity_catalog_group_name = string
    unity_catalog_sp_name    = string

    # Variables for User-specific Cluster(s)
    user_specific_cluster_names = list(string)
    user_specific_cluster_config = object({
      spark_version_id            = optional(string, "15.4.x-scala2.12")
      node_type_id                = optional(string, "Standard_DS3_v2")
      autoterminate_after_minutes = optional(number, 30)
      tags                        = optional(map(string), {})
      minimum_workers             = optional(number, 1)
      maximum_workers             = optional(number, 2)
      extra_spark_configuration   = optional(map(string), {})
    })

    # Service Principal IAM
    service_principal_configuration_iam = object({
      name           = string
      application_id = string
    })
  })
  default = null
}

variable "adf_diagnostics_vars" {
  type = object({
    diagnostic_setting_name        = optional(string, "NNDAP_log_analytics")
    log_analytics_workspace_id     = string
    log_analytics_destination_type = optional(string, null)
    enabled_logs                   = optional(list(string), [])
    metrics = optional(list(object({
      category = string
      enabled  = bool
    })), [])
  })
  default = null
}

variable "databricks_diagnostics_vars" {
  type = object({
    diagnostic_setting_name        = optional(string, "NNDAP_log_analytics")
    target_resource_id             = string
    log_analytics_workspace_id     = string
    log_analytics_destination_type = optional(string, null)
    enabled_logs                   = optional(list(string), [])
    metrics = optional(list(object({
      category = string
      enabled  = bool
    })), [])
  })
  default = null
}

variable "disk_encryption_diagnostics_vars" {
  type = object({
    diagnostic_setting_name        = optional(string, "NNDAP_log_analytics")
    log_analytics_workspace_id     = string
    log_analytics_destination_type = optional(string, null)
    enabled_logs                   = optional(list(string), [])
    metrics = optional(list(object({
      category = string
      enabled  = bool
    })), [])
  })
  default = null
}

variable "kv_infra_diagnostics_vars" {
  type = object({
    diagnostic_setting_name        = optional(string, "NNDAP_log_analytics")
    log_analytics_workspace_id     = string
    log_analytics_destination_type = optional(string, null)
    enabled_logs                   = optional(list(string), [])
    metrics = optional(list(object({
      category = string
      enabled  = bool
    })), [])
  })
  default = null
}

variable "kv_sources_diagnostics_vars" {
  type = object({
    diagnostic_setting_name        = optional(string, "NNDAP_log_analytics")
    target_resource_id             = string
    log_analytics_workspace_id     = string
    log_analytics_destination_type = optional(string, null)
    enabled_logs                   = optional(list(string), [])
    metrics = optional(list(object({
      category = string
      enabled  = bool
    })), [])
  })
  default = null
}

variable "storage_diagnostics_vars" {
  type = object({
    diagnostic_setting_name        = optional(string, "NNDAP_log_analytics")
    storage_account_id             = string
    log_analytics_workspace_id     = string
    log_analytics_destination_type = optional(string, null)
    enabled_logs                   = optional(list(string), [])
    metrics = optional(list(object({
      category = string
      enabled  = bool
    })), [])
  })
  default = null
}

### ROLE ASSIGNMENTS ###
variable "adf_role_assignments_vars" {
  type = object({
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "databricks_role_assignments_vars" {
  type = object({
    resource_ids         = list(string)
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "kv_infra_role_assignments_vars" {
  type = object({
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "kv_sources_role_assignments_vars" {
  type = object({
    resource_ids         = list(string)
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "storage_role_assignments_vars" {
  type = object({
    resource_ids         = list(string)
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "interface_storage_role_assignments_vars" {
  type = object({
    resource_ids         = list(string)
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

### Start for DRY'ing up the role assignments
# variable "role_assignment_vars" {
#   type = object({
#     resource_ids = object({
#       data_factory = optional(list(string), [])
#       databricks = optional(list(string), [])
#       key_vault_infra = optional(list(string), [])
#       key_vault_sources = optional(list(string), [])
#       storage = optional(list(string), [])
#       storage_dac = optional(list(string), [])
#       virtual_machine = optional(list(string), [])
#     })
#     data_engineers = optional(map(string), {})
#     devops_engineers = optional(map(string), {})
#     adb_enterprise_applications = optional(map(string), {})
#     subscriptions = optional(map(string), {})
#     aad_groups = optional(object({
#       management = string
#       platform_engineer = string
#       data_engineer = string
#       migration = string
#     }))
#   })
#   default = null
# }

variable "version_vars" {
  type = object({
    storage_account_name   = string
    storage_container_name = string
    blob_folder            = string
    infra_modules_version  = string
  })
}
