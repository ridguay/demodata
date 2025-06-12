resource "azurerm_databricks_workspace" "workspace" {
  name                = var.workspace__name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.workspace__tags
  sku                 = "premium"

  managed_resource_group_name = var.workspace__managed_resource_group_name

  custom_parameters {
    no_public_ip = var.workspace__secure_cluster_connectivity

    virtual_network_id                                   = data.azurerm_virtual_network.virtual_network.id
    public_subnet_network_security_group_association_id  = azurerm_subnet.public_subnet.id
    public_subnet_name                                   = azurerm_subnet.public_subnet.name
    private_subnet_network_security_group_association_id = azurerm_subnet.private_subnet.id
    private_subnet_name                                  = azurerm_subnet.private_subnet.name
  }

  # Somehow terraform wants to redeploy on a potential change of virtual_network_id, however, this did not change in practice
  # This block prevents the deployment
  lifecycle {
    ignore_changes = [custom_parameters[0].virtual_network_id]
  }

  depends_on = [data.azurerm_virtual_network.virtual_network]
}

resource "azurerm_private_endpoint" "databricks" {
  resource_group_name = var.resource_group_name
  name                = local.private_endpoint_name
  location            = var.location
  subnet_id           = var.workspace__private_endpoint_subnet_id
  tags                = var.workspace__tags

  private_service_connection {
    name                           = local.private_endpoint_service_connection_name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.workspace.id
    subresource_names              = ["databricks_ui_api"]
  }

  ip_configuration {
    name               = "ipconfig"
    private_ip_address = var.workspace__private_endpoint_ip
    subresource_name   = "databricks_ui_api"
  }

  # Ignore changes to the private DNS zone group, this binding is added by an NN-wide Azure policy. See also:
  # https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}
