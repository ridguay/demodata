# ### Key Vault Infra ###
module "key_vault_infra" {
  source = "./key_vault_infra"

  count = var.key_vault_vars == null ? 0 : 1

  resource_group_name                    = var.resource_group_name
  tags                                   = var.tags
  key_vault_location                     = var.location
  key_vault_name                         = var.key_vault_vars.name
  key_vault_sku_name                     = var.key_vault_vars.sku_name
  key_vault_tenant_id                    = var.key_vault_vars.tenant_id
  key_vault_soft_delete_retention_days   = var.key_vault_vars.soft_delete_retention_days
  key_vault_enable_purge_protection      = var.key_vault_vars.enable_purge_protection
  key_vault_enable_rbac_authorization    = var.key_vault_vars.enable_rbac_authorization
  key_vault_enable_disk_encryption       = var.key_vault_vars.enable_disk_encryption
  network_control_allowed_subnet_ids     = var.key_vault_vars.network_control_allowed_subnet_ids
  network_control_allowed_ip_rules       = var.key_vault_vars.network_control_allowed_ip_rules
  network_control_allowed_azure_services = var.key_vault_vars.network_control_allowed_azure_services
  private_endpoint_subnet_id             = var.key_vault_vars.private_endpoint_subnet_id
  create_private_endpoint                = var.key_vault_vars.create_private_endpoint
  key_vault_private_endpoint_ip          = var.key_vault_vars.key_vault_private_endpoint_ip

  depends_on = [module.vm]
}

resource "azurerm_key_vault_secret" "secret" {
  # We should in the future be able to deploy multiple VMs and put all their respective secrets in the key vault.
  # During phase 5 implementation, this was outside of scope, tried to get it working, but did not manage to do this within the time.
  # Problem lies in the fact that this count relies on a value that's only known after apply, so could not test this properly (yet). Maybe after phase 5 is done.
  count = var.key_vault_vars == null ? 0 : length(local.kv_secrets)

  name         = local.kv_secrets_names[count.index]
  value        = local.kv_secrets[local.kv_secrets_names[count.index]]
  key_vault_id = module.key_vault_infra[0].key_vault_id

  depends_on = [module.key_vault_infra, module.kv_infra_role_assignments]
}

### Data Factory + SHIR ###
module "data_factory" {
  source = "./data_factory"

  count = var.data_factory_vars == null ? 0 : length(var.data_factory_vars)

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  # Data Factory Instance
  name                       = var.data_factory_vars[count.index].name
  public_network_enabled     = var.data_factory_vars[count.index].public_network_enabled
  identity_type              = var.data_factory_vars[count.index].identity_type
  identity_ids               = var.data_factory_vars[count.index].identity_ids
  global_parameters          = var.data_factory_vars[count.index].global_parameters
  git_sync_configuration     = var.data_factory_vars[count.index].git_sync_configuration
  private_endpoint_subnet_id = var.data_factory_vars[count.index].private_endpoint_subnet_id
  private_endpoint_ip        = var.data_factory_vars[count.index].private_endpoint_ip

  # Key Vault SHIR
  key_vault_name                                   = var.data_factory_vars[count.index].key_vault_name
  key_vault_sku_name                               = var.data_factory_vars[count.index].key_vault_sku_name
  key_vault_tenant_id                              = var.data_factory_vars[count.index].key_vault_tenant_id
  key_vault_soft_delete_retention_days             = var.data_factory_vars[count.index].key_vault_soft_delete_retention_days
  key_vault_enable_purge_protection                = var.data_factory_vars[count.index].key_vault_enable_purge_protection
  key_vault_enable_rbac_authorization              = var.data_factory_vars[count.index].key_vault_enable_rbac_authorization
  key_vault_enable_disk_encryption                 = var.data_factory_vars[count.index].key_vault_enable_disk_encryption
  key_vault_network_control_allowed_subnet_ids     = var.data_factory_vars[count.index].key_vault_network_control_allowed_subnet_ids
  key_vault_network_control_allowed_ip_rules       = var.data_factory_vars[count.index].key_vault_network_control_allowed_ip_rules
  key_vault_network_control_allowed_azure_services = var.data_factory_vars[count.index].key_vault_network_control_allowed_azure_services
  key_vault_private_endpoint_subnet_id             = var.data_factory_vars[count.index].key_vault_private_endpoint_subnet_id
  key_vault_create_private_endpoint                = var.data_factory_vars[count.index].key_vault_create_private_endpoint

  # SHIR
  shir_name = var.data_factory_vars[count.index].shir_name

  # Azure Hosted Integration Runtime
  azure_integration_runtime_name = var.data_factory_vars[count.index].azure_integration_runtime_name
  storage_account_id             = var.data_factory_vars[count.index].storage_account_id
  managed_private_endpoint_name  = var.data_factory_vars[count.index].managed_private_endpoint_name
}

module "vm" {
  source = "./virtual_machine"

  count = var.virtual_machine_vars == null ? 0 : length(var.virtual_machine_vars)

  resource_group_name                          = var.resource_group_name
  virtual_machine_name                         = "${var.virtual_machine_vars[count.index].virtual_machine_name_prefix}${count.index}"
  virtual_machine_location                     = var.location
  tags                                         = var.tags
  virtual_machine_private_ip_address           = var.virtual_machine_vars[count.index].virtual_machine_private_ip_addresses[count.index]
  virtual_machine_size                         = var.virtual_machine_vars[count.index].virtual_machine_size
  virtual_machine_os_disk_storage_account_type = var.virtual_machine_vars[count.index].virtual_machine_os_disk_storage_account_type
  virtual_machine_os_disk_size_gb              = var.virtual_machine_vars[count.index].virtual_machine_os_disk_size_gb
  virtual_machine_timezone                     = var.virtual_machine_vars[count.index].virtual_machine_timezone
  virtual_machine_subnet_id                    = var.virtual_machine_vars[count.index].virtual_machine_subnet_id
  virtual_machine_application_ids              = var.virtual_machine_vars[count.index].virtual_machine_application_ids

  # Virtual Machine Extensions + Applications
  artifactory_password             = data.azurerm_key_vault_secret.artifactory_password.value # Enables us to - in the future - pass the artifactory password as a variable retrieved from the meta key vault in the functional layer
  monitoring_agent_config          = var.virtual_machine_vars[count.index].monitoring_agent_config
  diagnostics_storage_account_name = var.virtual_machine_vars[count.index].diagnostics_storage_account_name
  law_data_collection_rule_id      = var.virtual_machine_vars[count.index].law_data_collection_rule_id
  vm_patch                         = var.virtual_machine_vars[count.index].vm_patch
  shir_key_vault_uri               = module.data_factory[count.index].vault_uri
  shir_key_vault_id                = module.data_factory[count.index].key_vault_id
  shir_authorization_key           = module.data_factory[count.index].shir_authorization_key
  adf_private_endpoint_fqdn        = module.data_factory[count.index].private_endpoint_fqdn
  adf_private_endpoint_ip_address  = module.data_factory[count.index].private_endpoint_ip_address

  depends_on = [module.data_factory]
}

# # Included this as a separate submodule, as the locals needed to make the API call are depending on the creation of the azurerm_data_factory_managed_private_endpoint resource
module "approve_managed_pe_connection" {
  count = try(var.data_factory_vars.azure_integration_runtime_name, "") == "" ? 0 : length(var.data_factory_vars)

  source = "./approve_managed_private_endpoint"

  storage_account_id = var.data_factory_vars[count.index].storage_account_id
  managed_pe_name    = module.data_factory[count.index].managed_pe_name

  depends_on = [module.data_factory]
}

### Databricks ###
module "databricks" {
  source = "./databricks"

  providers = {
    azurerm      = azurerm
    azurerm.meta = azurerm.meta
    databricks   = databricks
  }

  count = var.databricks_functional_vars == null ? 0 : 1

  # General Vars
  meta_key_vault_id = data.azurerm_key_vault.meta_key_vault.id

  # Variables for Workspace Config
  workspace_config__nn_pypi_index_url          = var.databricks_functional_vars.workspace_config_nn_pypi_index_url
  workspace_config__nn_customer_pypi_index_url = var.databricks_functional_vars.workspace_config_nn_customer_pypi_index_url
  workspace_config__kafka_secret               = data.azurerm_key_vault_secret.kafka_certificate.value

  # Notebook Mounting Secrets
  notebook_mounting_secret_scope = var.databricks_functional_vars.notebook_mounting_secret_scope
  notebook_mounting_secrets      = var.databricks_functional_vars.notebook_mounting_secrets

  # Variables for Legacy Clusters
  legacy_cluster__names               = var.databricks_functional_vars.legacy_cluster_names
  legacy_user_specific_cluster__names = var.databricks_functional_vars.legacy_user_specific_cluster_names
  legacy_cluster__spark_version_id    = var.databricks_functional_vars.cluster_config.legacy_spark_version_id
  legacy_cluster__pypi_packages       = var.databricks_functional_vars.cluster_pypi_packages

  # Variables for Primary Cluster(s)
  cluster__names                       = var.databricks_functional_vars.cluster_names
  cluster__spark_version_id            = var.databricks_functional_vars.cluster_config.spark_version_id
  cluster__node_type_id                = var.databricks_functional_vars.cluster_config.node_type_id
  cluster__autoterminate_after_minutes = var.databricks_functional_vars.cluster_config.autoterminate_after_minutes
  cluster__tags                        = var.databricks_functional_vars.cluster_config.tags
  cluster__minimum_workers             = var.databricks_functional_vars.cluster_config.minimum_workers
  cluster__maximum_workers             = var.databricks_functional_vars.cluster_config.maximum_workers
  cluster__extra_spark_configuration   = var.databricks_functional_vars.cluster_config.extra_spark_configuration
  cluster__pypi_packages               = setsubtract(var.databricks_functional_vars.cluster_pypi_packages, ["pydantic==2.3.0"])
  cluster__runtime_engine              = var.databricks_functional_vars.cluster_config.runtime_engine

  cluster__uc_enabled                                  = var.databricks_functional_vars.cluster_uc_enabled
  cluster__legacy_clusters_enabled                     = var.databricks_functional_vars.legacy_clusters_enabled
  cluster__unity_catalog_volume_name                   = var.databricks_functional_vars.cluster_unity_catalog_volume_name
  cluster__unity_catalog_volume_storage_account_name   = var.databricks_functional_vars.cluster_unity_catalog_volume_storage_account_name
  cluster__unity_catalog_volume_storage_container_name = var.databricks_functional_vars.cluster_unity_catalog_volume_storage_container_name

  # Variables for User-Specific Cluster(s)
  user_specific_cluster__names                       = var.databricks_functional_vars.user_specific_cluster_names
  user_specific_cluster__spark_version_id            = var.databricks_functional_vars.user_specific_cluster_config.spark_version_id
  user_specific_cluster__node_type_id                = var.databricks_functional_vars.user_specific_cluster_config.node_type_id
  user_specific_cluster__autoterminate_after_minutes = var.databricks_functional_vars.user_specific_cluster_config.autoterminate_after_minutes
  user_specific_cluster__tags                        = var.databricks_functional_vars.user_specific_cluster_config.tags
  user_specific_cluster__minimum_workers             = var.databricks_functional_vars.user_specific_cluster_config.minimum_workers
  user_specific_cluster__maximum_workers             = var.databricks_functional_vars.user_specific_cluster_config.maximum_workers
  user_specific_cluster__extra_spark_configuration   = var.databricks_functional_vars.user_specific_cluster_config.extra_spark_configuration

  # Variables for DAB secrets
  workspace_url = var.databricks_functional_vars.workspace_url
  env_domain    = var.databricks_functional_vars.env_domain

  # Variables for service principals
  service_principal_configuration_iam = var.databricks_functional_vars.service_principal_configuration_iam

  # Variables for unity catalog
  unity_catalog_group_name = var.databricks_functional_vars.unity_catalog_group_name
  unity_catalog_sp_name    = var.databricks_functional_vars.unity_catalog_sp_name

  depends_on = [
    module.storage_role_assignments
  ]
}

### ADF Infra Components ###
module "adf_infra_components" {
  source = "./adf_infra_components"

  count = var.adf_infra_components_vars == null ? 0 : 1

  resource_group_name            = var.resource_group_name
  data_factory_id                = module.data_factory[0].id
  integration_runtime_name       = module.data_factory[0].shir_name
  azure_integration_runtime_name = module.data_factory[0].azure_ir_name
  # Databricks Linked Service Variables
  databricks_workspace_id  = var.adf_infra_components_vars.databricks_workspace_id
  databricks_workspace_url = var.adf_infra_components_vars.databricks_workspace_url
  databricks_cluster_ids   = module.databricks[0].cluster_ids
  pool_id                  = var.adf_infra_components_vars.pool_id
  cluster_spark_version    = var.adf_infra_components_vars.cluster_spark_version
  # Key Vault Linked Service Variables
  key_vault_id = var.adf_infra_components_vars.key_vault_id
  # Run SQL Notebook
  notebook_path = var.adf_infra_components_vars.notebook_path
  # Start Stop VM
  subscription_id      = var.adf_infra_components_vars.subscription_id
  virtual_machine_name = module.vm[0].virtual_machine_name
  # Storage Connection Variables
  storage_account_primary_dfs_endpoint = var.adf_infra_components_vars.storage_account_primary_dfs_endpoint
  dataset_config                       = var.adf_infra_components_vars.dataset_config
  # User Specific Cluster Linked Services
  user_specific_cluster_ids = module.databricks[0].user_specific_cluster_ids
  legacy_clusters_enabled   = var.databricks_functional_vars.legacy_clusters_enabled

  depends_on = [module.data_factory, module.vm, module.databricks]
}

### Diagnostic Settings ###
# ADF 
module "adf_diagnostic_settings" {
  source = "./diagnostic_settings"

  count = var.adf_diagnostics_vars == null ? 0 : length(module.data_factory)

  diagnostic_setting_name        = var.adf_diagnostics_vars.diagnostic_setting_name
  target_resource_id             = module.data_factory[count.index].id
  log_analytics_workspace_id     = var.adf_diagnostics_vars.log_analytics_workspace_id
  log_analytics_destination_type = var.adf_diagnostics_vars.log_analytics_destination_type
  enabled_logs                   = var.adf_diagnostics_vars.enabled_logs
  metrics                        = var.adf_diagnostics_vars.metrics

  depends_on = [module.data_factory]
}

# Databricks Workspace
module "databricks_diagnostic_settings" {
  source = "./diagnostic_settings"

  count = var.databricks_diagnostics_vars == null ? 0 : 1

  diagnostic_setting_name        = var.databricks_diagnostics_vars.diagnostic_setting_name
  target_resource_id             = var.databricks_diagnostics_vars.target_resource_id
  log_analytics_workspace_id     = var.databricks_diagnostics_vars.log_analytics_workspace_id
  log_analytics_destination_type = var.databricks_diagnostics_vars.log_analytics_destination_type
  enabled_logs                   = var.databricks_diagnostics_vars.enabled_logs
  metrics                        = var.databricks_diagnostics_vars.metrics
}

# Disk Encryption Key Vault
module "disk_encryption_diagnostic_settings" {
  source = "./diagnostic_settings"

  count = var.disk_encryption_diagnostics_vars == null ? 0 : 1

  diagnostic_setting_name        = var.disk_encryption_diagnostics_vars.diagnostic_setting_name
  target_resource_id             = module.data_factory[count.index].key_vault_id
  log_analytics_workspace_id     = var.disk_encryption_diagnostics_vars.log_analytics_workspace_id
  log_analytics_destination_type = var.disk_encryption_diagnostics_vars.log_analytics_destination_type
  enabled_logs                   = var.disk_encryption_diagnostics_vars.enabled_logs
  metrics                        = var.disk_encryption_diagnostics_vars.metrics

  depends_on = [module.data_factory]
}

# Infra Key Vault
module "kv_infra_diagnostic_settings" {
  source = "./diagnostic_settings"

  count = var.kv_infra_diagnostics_vars == null ? 0 : 1

  diagnostic_setting_name        = var.kv_infra_diagnostics_vars.diagnostic_setting_name
  target_resource_id             = module.key_vault_infra[0].key_vault_id
  log_analytics_workspace_id     = var.kv_infra_diagnostics_vars.log_analytics_workspace_id
  log_analytics_destination_type = var.kv_infra_diagnostics_vars.log_analytics_destination_type
  enabled_logs                   = var.kv_infra_diagnostics_vars.enabled_logs
  metrics                        = var.kv_infra_diagnostics_vars.metrics

  depends_on = [module.key_vault_infra]
}

module "kv_sources_diagnostic_settings" {
  source = "./diagnostic_settings"

  count = var.kv_sources_diagnostics_vars == null ? 0 : 1

  diagnostic_setting_name        = var.kv_sources_diagnostics_vars.diagnostic_setting_name
  target_resource_id             = var.kv_sources_diagnostics_vars.target_resource_id
  log_analytics_workspace_id     = var.kv_sources_diagnostics_vars.log_analytics_workspace_id
  log_analytics_destination_type = var.kv_sources_diagnostics_vars.log_analytics_destination_type
  enabled_logs                   = var.kv_sources_diagnostics_vars.enabled_logs
  metrics                        = var.kv_sources_diagnostics_vars.metrics
}

module "storage_diagnostic_settings" {
  source = "./diagnostic_settings"

  for_each = local.storage_diagnostics_target_resource_ids

  diagnostic_setting_name        = var.storage_diagnostics_vars.diagnostic_setting_name
  target_resource_id             = each.value
  log_analytics_workspace_id     = var.storage_diagnostics_vars.log_analytics_workspace_id
  log_analytics_destination_type = var.storage_diagnostics_vars.log_analytics_destination_type
  enabled_logs                   = var.storage_diagnostics_vars.enabled_logs
  metrics                        = var.storage_diagnostics_vars.metrics
}

### ROLE ASSIGNMENTS ###
module "adf_role_assignments" {
  source = "./role_assignments"

  count = var.adf_role_assignments_vars == null ? 0 : length(module.data_factory)

  resource_ids         = [module.data_factory[count.index].id]
  user_principal_roles = var.adf_role_assignments_vars.user_principal_roles
  principal_id_roles   = var.adf_role_assignments_vars.principal_id_roles

  depends_on = [module.data_factory]
}

module "databricks_role_assignments" {
  source = "./role_assignments"

  count = var.databricks_role_assignments_vars == null ? 0 : 1

  resource_ids         = var.databricks_role_assignments_vars.resource_ids
  user_principal_roles = var.databricks_role_assignments_vars.user_principal_roles
  principal_id_roles = merge(
    var.databricks_role_assignments_vars.principal_id_roles,
    {
      adf  = ["Contributor"],
      adf2 = ["Contributor"],
    }
  )
  runtime_object_ids = local.runtime_object_ids

  depends_on = [module.data_factory]
}

module "kv_infra_role_assignments" {
  source = "./role_assignments"

  count = var.kv_infra_role_assignments_vars == null ? 0 : 1

  resource_ids         = [module.key_vault_infra[0].key_vault_id]
  user_principal_roles = var.kv_infra_role_assignments_vars.user_principal_roles
  principal_id_roles   = var.kv_infra_role_assignments_vars.principal_id_roles

  depends_on = [module.key_vault_infra]
}

module "kv_sources_role_assignments" {
  source = "./role_assignments"

  count = var.kv_sources_role_assignments_vars == null ? 0 : 1

  resource_ids         = var.kv_sources_role_assignments_vars.resource_ids
  user_principal_roles = var.kv_sources_role_assignments_vars.user_principal_roles
  principal_id_roles = merge(
    var.kv_sources_role_assignments_vars.principal_id_roles,
    {
      adf  = ["Key Vault Secrets User"],
      adf2 = ["Key Vault Secrets User"],
    }
  )
  runtime_object_ids = local.runtime_object_ids

  depends_on = [module.data_factory]
}

module "storage_role_assignments" {
  source = "./role_assignments"

  count = var.storage_role_assignments_vars == null ? 0 : 1

  resource_ids         = var.storage_role_assignments_vars.resource_ids
  user_principal_roles = var.storage_role_assignments_vars.user_principal_roles
  principal_id_roles = merge(
    var.storage_role_assignments_vars.principal_id_roles,
    {
      adf  = ["Storage Blob Data Contributor", "Storage Table Data Contributor"],
      adf2 = ["Storage Blob Data Contributor", "Storage Table Data Contributor"],
    }
  )
  runtime_object_ids = local.runtime_object_ids

  depends_on = [module.data_factory]
}

module "interface_storage_role_assignments" {
  source = "./role_assignments"

  count = var.interface_storage_role_assignments_vars == null ? 0 : 1

  resource_ids         = var.interface_storage_role_assignments_vars.resource_ids
  user_principal_roles = var.interface_storage_role_assignments_vars.user_principal_roles
  principal_id_roles = merge(
    var.interface_storage_role_assignments_vars.principal_id_roles,
    {
      adf  = ["Storage Blob Data Contributor", "Storage Table Data Contributor"],
      adf2 = ["Storage Blob Data Contributor", "Storage Table Data Contributor"],
    }
  )
  runtime_object_ids = local.runtime_object_ids

  depends_on = [module.data_factory]
}

module "vm_role_assignments" {
  source = "./role_assignments"

  count = length(module.vm)

  resource_ids = [module.vm[count.index].virtual_machine_id]
  # Ugly hack to give permissions only to the first ADF for the first VM, and the second ADF for the second VM
  principal_id_roles = count.index == 0 ? {
    adf = ["Virtual Machine Contributor"]
    } : {
    adf2 = ["Virtual Machine Contributor"]
  }
  runtime_object_ids = local.runtime_object_ids

  depends_on = [module.vm, module.data_factory]
}

module "version" {
  source = "./version"

  providers = {
    azurerm.meta = azurerm.meta
  }

  storage_account_name   = var.version_vars.storage_account_name
  storage_container_name = var.version_vars.storage_container_name
  blob_folder            = var.version_vars.blob_folder
  infra_modules_version  = var.version_vars.infra_modules_version
}
