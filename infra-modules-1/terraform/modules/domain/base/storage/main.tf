resource "azurerm_storage_account" "storage" {
  account_replication_type        = var.storage_account_replication_type
  account_tier                    = var.storage_account_account_tier
  location                        = var.storage_account_location
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  tags                            = merge(var.tags, var.storage_account_extra_tags)
  shared_access_key_enabled       = var.shared_access_key_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication

  account_kind   = "StorageV2"
  is_hns_enabled = true
  access_tier    = "Hot"

  allow_nested_items_to_be_public  = false
  https_traffic_only_enabled       = true
  min_tls_version                  = "TLS1_2"
  cross_tenant_replication_enabled = false

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
    # Allow is needed for enabled public access which is needed for Pensions SAP CDC POC
    default_action             = var.configure_default_network_rules ? "Deny" : "Allow"
    bypass                     = var.network_rules_bypasses
    ip_rules                   = var.network_control_allowed_ip_rules
    virtual_network_subnet_ids = var.network_control_allowed_subnet_ids
    private_link_access {
      endpoint_resource_id = var.private_link_access_resource_id
      endpoint_tenant_id   = var.private_link_access_tenant_id
    }
  }

  identity {
    type = "SystemAssigned"
  }

}

resource "azurerm_storage_account_customer_managed_key" "storage_customer_managed_key" {
  count              = local.is_customer_managed_keys_provided ? 1 : 0
  storage_account_id = azurerm_storage_account.storage.id
  key_vault_id       = var.customer_managed_key.datalake_key_vault_id == null ? null : var.customer_managed_key.datalake_key_vault_id
  key_name           = var.customer_managed_key.key_name == null ? null : var.customer_managed_key.key_name

  depends_on = [
    azurerm_key_vault_access_policy.key_vault_customer_managed_key
  ]
}

resource "azurerm_key_vault_access_policy" "key_vault_customer_managed_key" {
  count        = local.is_customer_managed_keys_provided ? 1 : 0
  key_vault_id = var.customer_managed_key.datalake_key_vault_id
  tenant_id    = azurerm_storage_account.storage.identity.0.tenant_id
  object_id    = azurerm_storage_account.storage.identity.0.principal_id

  key_permissions = [
    "Backup", "Decrypt", "Get", "List", "Create", "Delete", "Encrypt",
    "Import", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]
}

# NOTE: Creating private endpoints to DFS and Blob service "because operations that target the Data Lake Storage Gen2 endpoint might be redirected to the Blob endpoint." - Source https://docs.microsoft.com/en-us/azure/storage/common/storage-private-endpoints#creating-a-private-endpoint
resource "azurerm_private_endpoint" "datalake_file_storage" {
  resource_group_name = var.resource_group_name
  name                = "${local.private_endpoint_name_prefix}-dfs"
  location            = var.storage_account_location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.private_endpoint_service_connection_name_prefix}-dfs"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.storage.id
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

resource "azurerm_private_endpoint" "blob" {
  resource_group_name = var.resource_group_name
  name                = "${local.private_endpoint_name_prefix}-blob"
  location            = var.storage_account_location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.private_endpoint_service_connection_name_prefix}-blob"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.storage.id
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

resource "azurerm_private_endpoint" "table" {
  count               = var.table_private_endpoint_ip != null ? 1 : 0
  resource_group_name = var.resource_group_name
  name                = "${local.private_endpoint_name_prefix}-table"
  location            = var.storage_account_location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.private_endpoint_service_connection_name_prefix}-table"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["table"]
  }

  ip_configuration {
    name               = "ipconfig"
    private_ip_address = var.table_private_endpoint_ip
    member_name        = "table"
    subresource_name   = "table"
  }

  # Ignore changes to the private DNS zone group, this binding is added by an NN-wide Azure policy. See also:
  # https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_storage_management_policy" "smp" {
  storage_account_id = azurerm_storage_account.storage.id
  rule {
    name    = "default_for_dap"
    enabled = true
    filters {
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = var.storage_management_policy.move_to_cool_after_days
      }
      snapshot {
        change_tier_to_cool_after_days_since_creation = local.smp_snapshot_tier_to_cool_days
      }
      version {
        change_tier_to_cool_after_days_since_creation = local.smp_version_tier_to_cool_days
      }
    }
  }
}

# When deploying a platform from scratch, it takes a while for the private endpoints to be approved or added to the NN network. As a result,
# we cannot start deploying storage containers right after the creation of the private endpoints and we need a timeout.
resource "time_sleep" "wait_5_minutes" {
  depends_on = [azurerm_private_endpoint.datalake_file_storage, azurerm_private_endpoint.blob]

  create_duration = "5m"
}

resource "azurerm_storage_container" "containers" {
  for_each = { for name in var.container_names : name => name }

  storage_account_name  = azurerm_storage_account.storage.name
  name                  = each.value
  container_access_type = "private"

  depends_on = [time_sleep.wait_5_minutes]
}
