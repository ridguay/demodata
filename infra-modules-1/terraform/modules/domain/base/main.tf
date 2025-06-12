### Resource Group ###
module "resource_group" {
  source = "./resource_group"

  name     = var.resource_group_vars.name
  location = var.location
  tags     = var.resource_group_vars.tags
}

### Services Subnet ###
module "services_subnet" {
  source = "./services_subnet"

  subnet_name           = var.services_subnet_vars.subnet_name
  subnet_address_prefix = var.services_subnet_vars.subnet_address_prefix
  virtual_network_data  = var.services_subnet_vars.virtual_network_data
}

### Databricks ###
module "databricks" {
  source = "./databricks"

  resource_group_name = module.resource_group.name

  access_connector__name = var.databricks_vars.access_connector_name
  access_connector__tags = var.databricks_vars.access_connector_tags

  subnet__name                          = var.databricks_vars.subnet_name
  subnet__tags                          = var.databricks_vars.subnet_tags
  subnet__private_subnet_address_prefix = var.databricks_vars.subnet_private_subnet_address_prefix
  subnet__public_subnet_address_prefix  = var.databricks_vars.subnet_public_subnet_address_prefix
  subnet__virtual_network_data = {
    resource_group_name = var.databricks_vars.subnet_virtual_network_data.resource_group_name
    name                = var.databricks_vars.subnet_virtual_network_data.name
  }

  workspace__managed_resource_group_name = var.databricks_vars.workspace_managed_resource_group_name
  workspace__name                        = var.databricks_vars.workspace_name
  workspace__tags                        = var.databricks_vars.workspace_tags
  workspace__secure_cluster_connectivity = var.databricks_vars.workspace_secure_cluster_connectivity
  workspace__private_endpoint_subnet_id  = module.services_subnet.subnet_id
  workspace__private_endpoint_ip         = var.databricks_vars.workspace_private_endpoint_ip

  depends_on = [module.resource_group, module.services_subnet]
}

module "key_vault_sources" {
  source = "./key_vault"
  count  = var.key_vault_sources_vars == null ? 0 : 1

  resource_group_name = module.resource_group.name
  key_vault_location  = var.location

  key_vault_name      = var.key_vault_sources_vars.name
  key_vault_sku_name  = var.key_vault_sources_vars.sku_name
  key_vault_tenant_id = var.tenant_id

  tags = var.key_vault_sources_vars.tags

  key_vault_soft_delete_retention_days = var.key_vault_sources_vars.soft_delete_retention_days
  key_vault_enable_purge_protection    = var.key_vault_sources_vars.enable_purge_protection
  key_vault_enable_rbac_authorization  = var.key_vault_sources_vars.enable_rbac_authorization
  key_vault_enable_disk_encryption     = var.key_vault_sources_vars.enable_disk_encryption
  key_vault_private_endpoint_ip        = var.key_vault_sources_vars.private_endpoint_ip

  # If the databricks module is deployed, the databricks subnet should be added to the allowed subnets ids
  network_control_allowed_subnet_ids     = concat(var.key_vault_sources_vars.network_control_allowed_subnet_ids, [module.databricks.private_subnet_id, module.databricks.public_subnet_id])
  network_control_allowed_ip_rules       = var.key_vault_sources_vars.network_control_allowed_ip_rules
  network_control_allowed_azure_services = var.key_vault_sources_vars.network_control_allowed_azure_services

  private_endpoint_subnet_id = module.services_subnet.subnet_id #var.key_vault_sources_vars.private_endpoint_subnet_id
  create_private_endpoint    = var.key_vault_sources_vars.create_private_endpoint

  depends_on = [module.resource_group, module.databricks, module.services_subnet]
}

module "storage" {
  source = "./storage"

  resource_group_name      = module.resource_group.name
  storage_account_location = var.location

  storage_account_name             = var.storage_vars.name
  storage_account_account_tier     = var.storage_vars.account_tier
  storage_account_replication_type = var.storage_vars.replication_type
  delete_policy                    = var.storage_vars.delete_policy
  customer_managed_key             = var.storage_vars.customer_managed_key
  storage_management_policy        = var.storage_vars.storage_management_policy

  tags                       = var.storage_vars.tags
  storage_account_extra_tags = var.storage_vars.storage_account_extra_tags

  # If the databricks module is deployed, the databricks subnet should be added to the allowed subnets ids
  network_control_allowed_subnet_ids = concat(var.storage_vars.network_control_allowed_subnet_ids, [module.databricks.private_subnet_id, module.databricks.public_subnet_id])
  network_control_allowed_ip_rules   = var.storage_vars.network_control_allowed_ip_rules
  configure_default_network_rules    = var.storage_vars.configure_default_network_rules
  private_link_access_tenant_id      = var.tenant_id
  private_link_access_resource_id    = module.databricks.databricks_access_connector_resource_id
  add_private_link_access            = var.storage_vars.add_private_link_access
  network_rules_bypasses             = var.storage_vars.network_rules_bypasses
  private_endpoint_subnet_id         = module.services_subnet.subnet_id #var.storage_vars.private_endpoint_subnet_id
  dfs_private_endpoint_ip            = var.storage_vars.dfs_private_endpoint_ip
  blob_private_endpoint_ip           = var.storage_vars.blob_private_endpoint_ip
  table_private_endpoint_ip          = var.storage_vars.table_private_endpoint_ip
  container_names                    = var.storage_vars.container_names
  shared_access_key_enabled          = var.storage_vars.shared_access_key_enabled
  default_to_oauth_authentication    = var.storage_vars.default_to_oauth_authentication

  depends_on = [module.resource_group, module.databricks, module.services_subnet]
}

module "interface_storage" {
  source = "./storage"
  count  = var.interface_storage_vars == null ? 0 : 1

  resource_group_name      = module.resource_group.name
  storage_account_location = var.location

  storage_account_name             = var.interface_storage_vars.name
  storage_account_account_tier     = var.interface_storage_vars.account_tier
  storage_account_replication_type = var.interface_storage_vars.replication_type
  delete_policy                    = var.interface_storage_vars.delete_policy
  customer_managed_key             = var.interface_storage_vars.customer_managed_key
  storage_management_policy        = var.interface_storage_vars.storage_management_policy

  tags                       = var.interface_storage_vars.tags
  storage_account_extra_tags = var.interface_storage_vars.storage_account_extra_tags

  # If the databricks module is deployed, the databricks subnet should be added to the allowed subnets ids
  network_control_allowed_subnet_ids = concat(var.interface_storage_vars.network_control_allowed_subnet_ids, [module.databricks.private_subnet_id, module.databricks.public_subnet_id])
  network_control_allowed_ip_rules   = var.interface_storage_vars.network_control_allowed_ip_rules
  configure_default_network_rules    = var.interface_storage_vars.configure_default_network_rules
  private_link_access_tenant_id      = var.tenant_id
  private_link_access_resource_id    = module.databricks.databricks_access_connector_resource_id
  add_private_link_access            = var.interface_storage_vars.add_private_link_access
  network_rules_bypasses             = var.interface_storage_vars.network_rules_bypasses
  private_endpoint_subnet_id         = module.services_subnet.subnet_id
  dfs_private_endpoint_ip            = var.interface_storage_vars.dfs_private_endpoint_ip
  blob_private_endpoint_ip           = var.interface_storage_vars.blob_private_endpoint_ip
  table_private_endpoint_ip          = var.interface_storage_vars.table_private_endpoint_ip
  container_names                    = var.interface_storage_vars.container_names
  shared_access_key_enabled          = var.interface_storage_vars.shared_access_key_enabled
  default_to_oauth_authentication    = var.interface_storage_vars.default_to_oauth_authentication

  depends_on = [module.resource_group, module.databricks, module.services_subnet]
}

module "logging" {
  source = "./logging"

  name                      = var.logging_vars.name
  automation_name           = var.logging_vars.automation_name
  data_collection_rule_name = var.logging_vars.data_collection_rule_name
  resource_group_name       = module.resource_group.name
  location                  = var.location
  retention_in_days         = var.logging_vars.retention_in_days
  tags                      = var.logging_vars.tags
}
