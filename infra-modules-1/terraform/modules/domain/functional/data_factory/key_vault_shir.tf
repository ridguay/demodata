resource "azurerm_key_vault" "key_vault" {
  location            = var.location
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
  sku_name            = var.key_vault_sku_name
  tenant_id           = var.key_vault_tenant_id
  tags                = var.tags

  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_enable_purge_protection

  enabled_for_disk_encryption = var.key_vault_enable_disk_encryption
  enable_rbac_authorization   = var.key_vault_enable_rbac_authorization

  network_acls {
    default_action             = "Deny"
    bypass                     = var.key_vault_enable_disk_encryption || var.key_vault_network_control_allowed_azure_services ? "AzureServices" : "None"
    ip_rules                   = var.key_vault_network_control_allowed_ip_rules
    virtual_network_subnet_ids = var.key_vault_network_control_allowed_subnet_ids
  }

  lifecycle {
    ignore_changes = [
      access_policy, # Access policies are managed using `azurerm_key_vault_access_policy` resources
    ]
  }
}

resource "azurerm_private_endpoint" "network" {
  count = var.key_vault_create_private_endpoint ? 1 : 0

  location            = var.location
  name                = local.key_vault_private_endpoint_name_prefix
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = local.key_vault_private_endpoint_service_connection_name_prefix
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    subresource_names              = ["vault"]
  }

  # Ignore changes to the private DNS zone group, this binding is added by an NN-wide Azure policy. See also:
  # https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}