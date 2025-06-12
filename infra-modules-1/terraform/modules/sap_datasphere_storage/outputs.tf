output "resource_group__name" {
  value = module.resource_group.name
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