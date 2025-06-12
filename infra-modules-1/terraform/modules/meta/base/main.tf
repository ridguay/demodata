module "tfstate_subnet" {
  source = "./subnet"

  subnet_name           = var.tfstate_subnet_vars.subnet_name
  tags                  = var.tfstate_subnet_vars.tags # Not using general tags to prevent recreation (for now)
  subnet_address_prefix = var.tfstate_subnet_vars.subnet_address_prefix
  virtual_network_data  = var.virtual_network_data
}

module "services_subnet" {
  source = "./subnet"

  subnet_name           = var.services_subnet_vars.subnet_name
  tags                  = var.tags
  subnet_address_prefix = var.services_subnet_vars.subnet_address_prefix
  virtual_network_data  = var.virtual_network_data
}

module "tfstate_storage" {
  source = "./storage"

  resource_group_name        = var.meta_resource_group_name
  storage_account_name       = var.tfstate_storage_vars.storage_account_name
  deploy_storage_account     = false
  location                   = var.location
  tags                       = var.tags
  shared_access_key_enabled  = var.tfstate_storage_vars.shared_access_key_enabled
  private_endpoint_subnet_id = module.tfstate_subnet.subnet_id
  blob_private_endpoint_ip   = var.tfstate_storage_vars.blob_private_endpoint_ip
  container_names            = var.tfstate_storage_vars.container_names

  depends_on = [module.tfstate_subnet]
}

module "utility_storage" {
  source = "./storage"

  resource_group_name                = var.meta_resource_group_name
  storage_account_name               = var.utility_storage_vars.storage_account_name
  location                           = var.location
  tags                               = var.utility_storage_vars.tags
  shared_access_key_enabled          = var.utility_storage_vars.shared_access_key_enabled
  allow_nested_items_to_be_public    = var.utility_storage_vars.allow_nested_items_to_be_public
  enabled_from_all_networks          = var.utility_storage_vars.enabled_from_all_networks
  network_control_allowed_subnet_ids = var.utility_storage_vars.network_control_allowed_subnet_ids
  private_endpoint_subnet_id         = module.tfstate_subnet.subnet_id
  blob_private_endpoint_ip           = var.utility_storage_vars.blob_private_endpoint_ip
  container_names                    = var.utility_storage_vars.container_names
  container_access                   = var.utility_storage_vars.container_access

  depends_on = [module.tfstate_subnet]
}

module "key_vault_iam" {
  source = "./key_vault"

  resource_group_name = var.meta_resource_group_name
  key_vault_location  = var.location

  key_vault_name      = var.key_vault_iam_vars.name
  key_vault_sku_name  = var.key_vault_iam_vars.sku_name
  key_vault_tenant_id = var.tenant_id

  tags = var.key_vault_iam_vars.tags

  key_vault_soft_delete_retention_days = var.key_vault_iam_vars.soft_delete_retention_days
  key_vault_enable_purge_protection    = var.key_vault_iam_vars.enable_purge_protection
  key_vault_enable_rbac_authorization  = var.key_vault_iam_vars.enable_rbac_authorization
  key_vault_enable_disk_encryption     = var.key_vault_iam_vars.enable_disk_encryption
  key_vault_private_endpoint_ip        = var.key_vault_iam_vars.private_endpoint_ip

  # If the databricks module is deployed, the databricks subnet should be added to the allowed subnets ids
  network_control_allowed_subnet_ids     = concat(var.key_vault_iam_vars.network_control_allowed_subnet_ids, [module.databricks.private_subnet_id, module.databricks.public_subnet_id])
  network_control_allowed_ip_rules       = var.key_vault_iam_vars.network_control_allowed_ip_rules
  network_control_allowed_azure_services = var.key_vault_iam_vars.network_control_allowed_azure_services

  private_endpoint_subnet_id = module.services_subnet.subnet_id
  create_private_endpoint    = var.key_vault_iam_vars.create_private_endpoint

  depends_on = [module.databricks, module.services_subnet]
}

module "key_vault_envs" {
  source = "./key_vault"

  resource_group_name = var.meta_resource_group_name
  key_vault_location  = var.location

  key_vault_name      = var.key_vault_envs_vars.name
  key_vault_sku_name  = var.key_vault_envs_vars.sku_name
  key_vault_tenant_id = var.tenant_id

  tags = var.key_vault_envs_vars.tags

  key_vault_soft_delete_retention_days = var.key_vault_envs_vars.soft_delete_retention_days
  key_vault_enable_purge_protection    = var.key_vault_envs_vars.enable_purge_protection
  key_vault_enable_rbac_authorization  = var.key_vault_envs_vars.enable_rbac_authorization
  key_vault_enable_disk_encryption     = var.key_vault_envs_vars.enable_disk_encryption
  key_vault_private_endpoint_ip        = var.key_vault_envs_vars.private_endpoint_ip

  # If the databricks module is deployed, the databricks subnet should be added to the allowed subnets ids
  network_control_allowed_subnet_ids     = concat(var.key_vault_envs_vars.network_control_allowed_subnet_ids, [module.databricks.private_subnet_id, module.databricks.public_subnet_id])
  network_control_allowed_ip_rules       = var.key_vault_envs_vars.network_control_allowed_ip_rules
  network_control_allowed_azure_services = var.key_vault_envs_vars.network_control_allowed_azure_services

  private_endpoint_subnet_id = module.tfstate_subnet.subnet_id
  create_private_endpoint    = var.key_vault_envs_vars.create_private_endpoint

  depends_on = [module.databricks, module.tfstate_subnet]
}

module "logging_storage" {
  source = "./storage"

  resource_group_name                = var.meta_resource_group_name
  storage_account_name               = var.logging_storage_vars.storage_account_name
  location                           = var.location
  tags                               = var.logging_storage_vars.tags
  shared_access_key_enabled          = var.logging_storage_vars.shared_access_key_enabled
  public_network_access_enabled      = var.logging_storage_vars.public_network_access_enabled
  allow_nested_items_to_be_public    = var.logging_storage_vars.allow_nested_items_to_be_public
  enabled_from_all_networks          = var.logging_storage_vars.enabled_from_all_networks
  network_control_allowed_subnet_ids = var.logging_storage_vars.network_control_allowed_subnet_ids
  private_endpoint_subnet_id         = module.services_subnet.subnet_id
  blob_private_endpoint_ip           = var.logging_storage_vars.blob_private_endpoint_ip
  dfs_private_endpoint_ip            = var.logging_storage_vars.dfs_private_endpoint_ip
  container_names                    = var.logging_storage_vars.container_names
  container_access                   = var.logging_storage_vars.container_access

  depends_on = [module.services_subnet]
}

module "logging" {
  source = "./logging"

  name                      = var.logging_vars.name
  automation_name           = var.logging_vars.automation_name
  data_collection_rule_name = var.logging_vars.data_collection_rule_name
  resource_group_name       = var.meta_resource_group_name
  location                  = var.location
  retention_in_days         = var.logging_vars.retention_in_days
  tags                      = var.logging_vars.tags
  subscription_id           = var.logging_vars.subscription_id
}

module "databricks" {
  source = "./databricks"

  resource_group_name = var.meta_resource_group_name

  access_connector__name = var.databricks_vars.access_connector_name
  access_connector__tags = var.databricks_vars.access_connector_tags

  subnet__name                          = var.databricks_vars.subnet_name
  subnet__tags                          = var.databricks_vars.subnet_tags
  subnet__private_subnet_address_prefix = var.databricks_vars.subnet_private_subnet_address_prefix
  subnet__public_subnet_address_prefix  = var.databricks_vars.subnet_public_subnet_address_prefix
  subnet__virtual_network_data = {
    resource_group_name = var.virtual_network_data.resource_group_name
    name                = var.virtual_network_data.name
  }

  workspace__managed_resource_group_name = var.databricks_vars.workspace_managed_resource_group_name
  workspace__name                        = var.databricks_vars.workspace_name
  workspace__tags                        = var.databricks_vars.workspace_tags
  workspace__secure_cluster_connectivity = var.databricks_vars.workspace_secure_cluster_connectivity
  workspace__private_endpoint_subnet_id  = module.services_subnet.subnet_id
  workspace__private_endpoint_ip         = var.databricks_vars.workspace_private_endpoint_ip

  depends_on = [module.services_subnet]
}

module "gallery" {
  source = "./gallery"

  gallery_name        = var.gallery_name
  resource_group_name = var.meta_resource_group_name
  location            = var.location
  tags                = var.tags
}
