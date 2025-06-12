output "name" {
  description = "The name of the Resource Group instance"
  value       = azurerm_resource_group.rg.name
}

output "id" {
  description = "Id of the Resource Group instance"
  value       = azurerm_resource_group.rg.id
}