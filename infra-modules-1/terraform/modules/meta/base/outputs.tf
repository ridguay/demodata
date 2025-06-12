output "gallery__id" {
  description = "The Id of the VM Application Gallery instance"
  value       = module.gallery.gallery_id
}

output "utility_storage__storage_account_name" {
  description = "The name of the utility storage account."
  value       = module.utility_storage.storage_account_name
}

output "utility_storage__connection_string" {
  description = "The connection string for the utility storage."
  value       = module.utility_storage.connection_string
  sensitive   = true
}

output "key_vault_iam__id" {
  description = "The Id of the IAM Key Vault instance"
  value       = module.key_vault_iam.key_vault_id
}

output "key_vault_envs__id" {
  description = "The Id of the ENVS Key Vault instance"
  value       = module.key_vault_envs.key_vault_id
}

output "databricks__workspace_id" {
  description = "The Id of the Databricks workspace instance"
  value       = module.databricks.databricks_workspace_id
}
