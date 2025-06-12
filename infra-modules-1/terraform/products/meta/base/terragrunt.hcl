include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/meta/base///"
}

inputs = {
  # General inputs
  tenant_id                = "${include.root.locals.env_variables.tenant_id}"
  meta_resource_group_name = "rg-${include.root.locals.environment_label}"
  tags                     = include.root.locals.env_variables.environment.tags
  virtual_network_data     = include.root.locals.env_variables.environment.virtual_network_data
  gallery_name             = "lpdap_gallery" # Not wrapped inside an object because that'd be a bit too much overhead

  tfstate_subnet_vars = {
    subnet_name           = "snet-${include.root.locals.environment_label}-tfstate"
    subnet_address_prefix = include.root.locals.env_variables.environment.ip_addresses.tfstate_subnet
  }

  services_subnet_vars = {
    subnet_name           = "snet-${include.root.locals.environment_label}-services"
    subnet_address_prefix = include.root.locals.env_variables.environment.ip_addresses.services_subnet
  }

  tfstate_storage_vars = {
    storage_account_name      = replace("st${include.root.locals.environment_label}tfstate", "-", "")
    shared_access_key_enabled = true
    blob_private_endpoint_ip  = include.root.locals.env_variables.environment.ip_addresses.tfstate_blob_private_endpoint
    container_names           = ["dev", "tst", "acc", "prd", "build-agents-aca", "psdl", "sbx", "pdv", "iamtest"]
  }

  utility_storage_vars = {
    storage_account_name            = replace("st${include.root.locals.environment_label}utils", "-", "")
    resource_group_name             = "rg-${include.root.locals.environment_label}"
    container_names                 = ["drivers", "vm-applications"]
    container_access                = "blob"
    tags                            = "${merge(include.root.locals.env_variables.environment.tags, include.root.locals.env_variables.environment.utils_storage_tags)}"
    shared_access_key_enabled       = true
    blob_private_endpoint_ip        = include.root.locals.env_variables.environment.ip_addresses.utils_blob_private_endpoint
    allow_nested_items_to_be_public = true # Needed to allow vmapp script to download files from storage account. THIS IS NOT Allowing access from the internet.
    enabled_from_all_networks       = "Allow"
    network_control_allowed_subnet_ids = [
      "/subscriptions/e217d9a6-1f47-4e18-b17d-ae2264d2c2e1/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-DEV/subnets/snet-lpcnw-dev-services",
      "/subscriptions/e217d9a6-1f47-4e18-b17d-ae2264d2c2e1/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-DEV/subnets/snet-lpind-dev-services",
      "/subscriptions/e217d9a6-1f47-4e18-b17d-ae2264d2c2e1/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-DEV/subnets/snet-lppns-dev-services",
      "/subscriptions/cf5e657c-4f82-41d5-99f4-6b52bdd286cc/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-TST/subnets/snet-lpcnw-tst-services",
      "/subscriptions/cf5e657c-4f82-41d5-99f4-6b52bdd286cc/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-TST/subnets/snet-lpind-tst-services",
      "/subscriptions/cf5e657c-4f82-41d5-99f4-6b52bdd286cc/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-TST/subnets/snet-lppns-tst-services",
      "/subscriptions/5440a847-24fe-4497-bd16-16032b1391fb/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-ACC/subnets/snet-lpcnw-acc-services",
      "/subscriptions/5440a847-24fe-4497-bd16-16032b1391fb/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-ACC/subnets/snet-lpind-acc-services",
      "/subscriptions/5440a847-24fe-4497-bd16-16032b1391fb/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-ACC/subnets/snet-lppns-acc-services",
      "/subscriptions/33588745-f5f8-4435-a8b4-f26d04e727df/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-PRD/subnets/snet-lpcnw-prd-services",
      "/subscriptions/33588745-f5f8-4435-a8b4-f26d04e727df/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-PRD/subnets/snet-lpind-prd-services",
      "/subscriptions/33588745-f5f8-4435-a8b4-f26d04e727df/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-PRD/subnets/snet-lppns-prd-services",
      "/subscriptions/6f97d752-e2f2-4a0e-840c-8dd14889c37e/resourceGroups/AzureVnet-WE/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-WE/subnets/snet-lpdap-iam-integrationruntimes", # TODO: Remove?
      "/subscriptions/abcf057e-dd25-434c-9a58-921a9224fc92/resourceGroups/AzureVnet-WE/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-WE/subnets/snet-lpcnw-pdv-services",
      "/subscriptions/5dfca94e-960c-4da3-9c87-c2e207c549f8/resourceGroups/AzureVnet-WE/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-WE/subnets/snet-lpcnw-sbx-services",
      "/subscriptions/5dfca94e-960c-4da3-9c87-c2e207c549f8/resourceGroups/AzureVnet-WE/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-WE/subnets/snet-lpdm1-sbx-services",
      "/subscriptions/5dfca94e-960c-4da3-9c87-c2e207c549f8/resourceGroups/AzureVnet-WE/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-WE/subnets/snet-lpdm2-sbx-services"
    ]
  }

  key_vault_iam_vars = {
    name                                = "kv-${include.root.locals.environment_label}-iam"
    resource_group_name                 = "rg-${include.root.locals.environment_label}"
    private_endpoint_ip                 = include.root.locals.env_variables.environment.ip_addresses.iam_key_vault_private_endpoint
    key_vault_tenant_id                 = "${include.root.locals.env_variables.tenant_id}"
    key_vault_enable_rbac_authorization = true
    tags                                = include.root.locals.env_variables.environment.tags
    network_control_allowed_ip_rules    = include.root.locals.env_variables.allowed_ips
    network_control_allowed_subnet_ids = [
      "/subscriptions/8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-meta/subnets/snet-lpdapv001-meta-tfstate",
    ]
  }

  key_vault_envs_vars = {
    name                                = "kv-${include.root.locals.environment_label}-envs"
    resource_group_name                 = "rg-${include.root.locals.environment_label}"
    private_endpoint_ip                 = include.root.locals.env_variables.environment.ip_addresses.envs_key_vault_private_endpoint
    key_vault_tenant_id                 = "${include.root.locals.env_variables.tenant_id}"
    key_vault_enable_rbac_authorization = true
    tags                                = include.root.locals.env_variables.environment.tags
    network_control_allowed_ip_rules    = include.root.locals.env_variables.allowed_ips
    network_control_allowed_subnet_ids = [
      "/subscriptions/8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-meta/subnets/snet-lpdapv001-meta-tfstate",
    ]
  }

  logging_storage_vars = {
    storage_account_name          = replace("st${include.root.locals.environment_label}logging", "-", "")
    resource_group_name           = "rg-${include.root.locals.environment_label}"
    container_names               = ["logs"]
    tags                          = include.root.locals.env_variables.environment.tags
    shared_access_key_enabled     = true
    public_network_access_enabled = false
    blob_private_endpoint_ip      = include.root.locals.env_variables.environment.ip_addresses.logging_blob_private_endpoint
    dfs_private_endpoint_ip       = include.root.locals.env_variables.environment.ip_addresses.logging_dfs_private_endpoint
    enabled_from_all_networks     = "Deny"
  }

  logging_vars = {
    name                      = "log-${include.root.locals.environment_label}"
    automation_name           = "aa-${include.root.locals.environment_label}"
    data_collection_rule_name = "dcr-${include.root.locals.environment_label}"
    retention_in_days         = 90
    tags                      = include.root.locals.env_variables.environment.tags
    subscription_id           = include.root.locals.env_variables.subscription_id
  }

  databricks_vars = {
    # Access connector inputs
    access_connector_name = "dac-${include.root.locals.environment_label}"
    access_connector_tags = include.root.locals.env_variables.environment.tags

    # Subnet inputs
    subnet_name                          = "snet-${include.root.locals.environment_label}-databricks"
    subnet_tags                          = include.root.locals.env_variables.environment.tags
    subnet_public_subnet_address_prefix  = "${include.root.locals.env_variables.environment.ip_addresses.databricks_public_subnet}"
    subnet_private_subnet_address_prefix = "${include.root.locals.env_variables.environment.ip_addresses.databricks_private_subnet}"
    subnet_virtual_network_data          = include.root.locals.env_variables.environment.virtual_network_data

    # Workspace inputs
    workspace_name                        = "dbw-${include.root.locals.environment_label}"
    workspace_tags                        = include.root.locals.env_variables.environment.tags
    workspace_managed_resource_group_name = "dbw-${include.root.locals.environment_label}-mrg"
    workspace_private_endpoint_ip         = "${include.root.locals.env_variables.environment.ip_addresses.databricks_private_endpoint}"
    workspace_vnet_resource_group_name    = include.root.locals.env_variables.environment.virtual_network_data.resource_group_name
  }
}

# Sometimes the portal crashes because terragrunt tries multiple api calls at the same time
# This makes sure terragrunt waits 5 seconds and retries the command (max 3 times) when an error is encountered
# That is matched by the stated regex pattern
retryable_errors = [
  "(?s).*ERROR: .*CanceledAndSupersededDueToAnotherOperation.*PutSubnetOperation.*",
]
