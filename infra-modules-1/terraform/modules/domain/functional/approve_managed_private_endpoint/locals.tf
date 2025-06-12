# Retrieve the private endpoint connection name from the storage account based on the private endpoint name
locals {
  private_endpoint_connection_name = element([
    for connection in jsondecode(data.azapi_resource.storage_account.output).properties.privateEndpointConnections
    : connection.name
    if endswith(connection.properties.privateEndpoint.id, var.managed_pe_name)
  ], 0)
}