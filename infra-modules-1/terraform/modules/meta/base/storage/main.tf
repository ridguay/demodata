resource "azurerm_storage_account" "account" {
  count = var.deploy_storage_account ? 1 : 0

  account_replication_type        = var.storage_account_replication_type
  account_tier                    = var.storage_account_account_tier
  location                        = var.location
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  tags                            = var.tags
  shared_access_key_enabled       = var.shared_access_key_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication

  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  min_tls_version                  = "TLS1_2"
  cross_tenant_replication_enabled = false
  public_network_access_enabled    = var.public_network_access_enabled

  dynamic "blob_properties" {
    for_each = var.delete_policy == null ? [] : [1]
    content {
      delete_retention_policy {
        days = var.delete_policy.blob_delete_retention
      }
      container_delete_retention_policy {
        days = var.delete_policy.container_delete_retention
      }
    }
  }

  network_rules {
    default_action             = var.enabled_from_all_networks
    bypass                     = var.network_rules_bypasses
    ip_rules                   = var.network_control_allowed_ip_rules
    virtual_network_subnet_ids = var.network_control_allowed_subnet_ids
  }
}

resource "azurerm_private_endpoint" "blob" {
  resource_group_name = var.resource_group_name
  name                = "${local.private_endpoint_name_prefix}-blob"
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.private_endpoint_service_connection_name_prefix}-blob"
    is_manual_connection           = false
    private_connection_resource_id = var.deploy_storage_account ? azurerm_storage_account.account[0].id : data.azurerm_storage_account.tfstate[0].id
    subresource_names              = ["blob"]
  }

  ip_configuration {
    name               = "ipconfig"
    private_ip_address = var.blob_private_endpoint_ip
    member_name        = "blob"
    subresource_name   = "blob"
  }

  # Ignore changes to the private DNS zone group, this binding is added by an NN-wide Azure policy. See also:
  # https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_private_endpoint" "dfs" {
  count = var.dfs_private_endpoint_ip != null ? 1 : 0

  resource_group_name = var.resource_group_name
  name                = "${local.private_endpoint_name_prefix}-dfs"
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.private_endpoint_service_connection_name_prefix}-dfs"
    is_manual_connection           = false
    private_connection_resource_id = var.deploy_storage_account ? azurerm_storage_account.account[0].id : data.azurerm_storage_account.tfstate[0].id
    subresource_names              = ["dfs"]
  }

  ip_configuration {
    name               = "ipconfig"
    private_ip_address = var.dfs_private_endpoint_ip
    member_name        = "dfs"
    subresource_name   = "dfs"
  }

  # Ignore changes to the private DNS zone group, this binding is added by an NN-wide Azure policy. See also:
  # https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_storage_container" "containers" {
  for_each = { for name in var.container_names : name => name }

  storage_account_name = var.storage_account_name

  # In azurerm provider 5.0, 'storage_account_name' will be deprecated. Versions after 4.9.0 support using the storage account id.
  # This line should be used if we upgrade our provider version to one higher than 4.9.0.
  # storage_account_id = data.azurerm_storage_account.tfstate.id

  name                  = each.value
  container_access_type = var.container_access
}
