# Approve the private endpoint
resource "azapi_update_resource" "approval" {
  type      = "Microsoft.Storage/storageAccounts/privateEndpointConnections@2022-09-01"
  name      = local.private_endpoint_connection_name
  parent_id = var.storage_account_id

  body = jsonencode({
    properties = {
      privateLinkServiceConnectionState = {
        description = "Approved via Terraform"
        status      = "Approved"
      }
    }
  })

  lifecycle {
    ignore_changes = all
  }
}