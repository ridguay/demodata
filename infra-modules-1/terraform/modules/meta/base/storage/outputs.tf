output "storage_account_name" {
  description = "The name of the utility storage account."
  value       = try(azurerm_storage_account.account[0].name, "")
}

output "connection_string" {
  description = "The access key of the Storage Account instance"
  value       = try(azurerm_storage_account.account[0].primary_connection_string, "")
  sensitive   = true
}
