output "resource_group__name" {
  value = module.resource_group.name
}

output "services_subnet__id" {
  value = module.services_subnet.subnet_id
}

output "services_subnet__name" {
  value = module.services_subnet.subnet_name
}

output "services_subnet__nsg_id" {
  value = module.services_subnet.network_security_group_id
}

output "services_subnet__nsg_name" {
  value = module.services_subnet.network_security_group_name
}

output "storage__storage_account_id" {
  value = module.storage.storage_id
}

output "storage__storage_account_name" {
  value = module.storage.name
}

output "storage__primary_dfs_endpoint" {
  value = module.storage.primary_dfs_endpoint
}

output "databricks__private_subnet_id" {
  value = module.databricks.private_subnet_id
}

output "databricks__public_subnet_id" {
  value = module.databricks.public_subnet_id
}

output "databricks__workspace_url" {
  value = module.databricks.databricks_workspace_url
}

output "databricks__workspace_id" {
  value = module.databricks.databricks_workspace_id
}

output "databricks__managed_identity_principal_id" {
  value = module.databricks.managed_identity_principal_id
}

output "databricks__access_connector_principal_id" {
  value = module.databricks.databricks_access_connector_principal_id
}

output "key_vault_sources__id" {
  value = try(module.key_vault_sources[0].key_vault_id, null)
}

output "log_analytics_workspace__workspace_id" {
  value = module.logging.workspace_id
}

output "log_analytics_workspace__primary_shared_key" {
  value     = module.logging.primary_shared_key
  sensitive = true
}

output "log_analytics_workspace__data_collection_rule_id" {
  value = module.logging.law_data_collection_rule_id
}

output "log_analytics_workspace__id" {
  value = module.logging.id
}

output "interface_storage__storage_account_id" {
  value = var.interface_storage_vars == null ? "" : module.interface_storage[0].storage_id
}