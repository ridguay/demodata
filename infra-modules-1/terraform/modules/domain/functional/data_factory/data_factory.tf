resource "azurerm_data_factory" "data_factory" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  public_network_enabled          = var.public_network_enabled
  managed_virtual_network_enabled = true # Allow Data Factory to host Azure managed integration runtimes in the VNet

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  dynamic "vsts_configuration" {
    for_each = var.git_sync_configuration == null ? [] : [1]

    content {
      account_name       = var.git_sync_configuration.account_name
      branch_name        = var.git_sync_configuration.branch_name
      project_name       = var.git_sync_configuration.project_name
      repository_name    = var.git_sync_configuration.repository_name
      root_folder        = var.git_sync_configuration.root_folder
      tenant_id          = var.git_sync_configuration.tenant_id
      publishing_enabled = var.git_sync_configuration.publishing_enabled
    }
  }

  # Global parameters are not overwritten by Terraform, used by ARM template deployments
  lifecycle {
    ignore_changes = [global_parameter]
  }
}

resource "azurerm_private_endpoint" "data_factory" {
  resource_group_name = var.resource_group_name
  name                = local.private_endpoint_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = local.private_endpoint_service_connection_name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    subresource_names              = ["dataFactory"]
  }

  ip_configuration {
    name               = "ipconfig"
    private_ip_address = var.private_endpoint_ip
    subresource_name   = "dataFactory"
  }

  # Ignore changes to the private DNS zone group, this binding is added by an NN-wide Azure policy. See also:
  # https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "adf_shir" {
  name            = var.shir_name
  data_factory_id = azurerm_data_factory.data_factory.id
}

resource "azurerm_data_factory_managed_private_endpoint" "managed_pe" {
  count = (var.azure_integration_runtime_name != "" && var.managed_private_endpoint_name != "") ? 1 : 0

  name               = var.managed_private_endpoint_name
  data_factory_id    = azurerm_data_factory.data_factory.id
  target_resource_id = var.storage_account_id
  subresource_name   = "dfs"
}

resource "azurerm_data_factory_integration_runtime_azure" "azure_ir" {
  count = var.azure_integration_runtime_name != "" ? 1 : 0

  name                    = var.azure_integration_runtime_name
  data_factory_id         = azurerm_data_factory.data_factory.id
  location                = var.location
  virtual_network_enabled = true
}
