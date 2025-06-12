# Retrieve the storage account details, including the private endpoint connections
data "azapi_resource" "storage_account" {
  type                   = "Microsoft.Storage/storageAccounts@2022-09-01"
  resource_id            = var.storage_account_id
  response_export_values = ["properties.privateEndpointConnections"]
}
