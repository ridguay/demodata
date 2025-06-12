include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/domain/base///"
}

generate "provider_databricks" {
  path      = "provider-databricks_workspace.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "databricks" {
  alias    = "default"
  azure_client_id = "${include.root.locals.env_variables.client_id}"
  azure_client_secret = var.azure_client_secret
}
EOF
}

generate "provider_azapi" {
  path      = "provider-azapi.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azapi" {
  client_id = "${include.root.locals.env_variables.client_id}"
  subscription_id = "${include.root.locals.env_variables.subscription_id}"
  tenant_id = "${include.root.locals.env_variables.tenant_id}"
  client_secret = var.azure_client_secret
}
EOF
}

locals {
  legacy_container_names = (include.root.locals.infrastructure_configuration.instance_type == "domain" ?
    (include.root.locals.infrastructure_configuration.legacy_clusters_enabled ?
      ["landing", "raw", "bronze", "silver"] :
      ["landing", "raw"]
    ) : []
  )
  container_names = toset(concat(
    local.legacy_container_names,
    ["${include.root.locals.cluster_unity_catalog_storage_container_name}"]
  ))
}

inputs = {
  # General inputs
  tenant_id = "${include.root.locals.env_variables.tenant_id}"

  # Resource specific inputs
  resource_group_vars = {
    name = "rg-${include.root.locals.environment_label}"
    tags = include.root.locals.env_variables.tags
  }

  services_subnet_vars = {
    subnet_name           = "snet-${include.root.locals.environment_label_short}-services"
    subnet_address_prefix = "${include.root.locals.domain_variables.ip_addresses.services_subnet}"
    virtual_network_data  = include.root.locals.env_variables.virtual_network_data
  }

  databricks_vars = {
    # Access connector inputs
    access_connector_name = "dac-${include.root.locals.environment_label}"
    access_connector_tags = include.root.locals.env_variables.tags

    # Subnet inputs
    subnet_name                          = "snet-${include.root.locals.environment_label_short}-databricks"
    subnet_tags                          = include.root.locals.env_variables.tags
    subnet_public_subnet_address_prefix  = "${include.root.locals.domain_variables.ip_addresses.databricks_public_subnet}"
    subnet_private_subnet_address_prefix = "${include.root.locals.domain_variables.ip_addresses.databricks_private_subnet}"
    subnet_virtual_network_data          = include.root.locals.env_variables.virtual_network_data

    # Workspace inputs
    workspace_name                        = "dbw-${include.root.locals.environment_label}"
    workspace_tags                        = include.root.locals.env_variables.tags
    workspace_managed_resource_group_name = "dbw-${include.root.locals.environment_label}-mrg"
    workspace_private_endpoint_ip         = "${include.root.locals.domain_variables.ip_addresses.databricks_private_endpoint}"
    workspace_vnet_resource_group_name    = include.root.locals.env_variables.virtual_network_data.resource_group_name
  }

  key_vault_sources_vars = {
    name                      = "kv-${include.root.locals.environment_label}-sources"
    tags                      = include.root.locals.env_variables.tags
    private_endpoint_ip       = "${include.root.locals.domain_variables.ip_addresses.key_vault_sources_private_endpoint}"
    enable_rbac_authorization = true

    # This list was used for the IP rules: https://nn.service-now.com/nn_ec?id=sc_cat_item&sys_id=e1738ba51bafd410797aea0e6e4bcbfb&sysparm_category=11b1adbedbce90106adb54904b961910
    network_control_allowed_azure_services = true
    network_control_allowed_subnet_ids     = []
    network_control_allowed_ip_rules = [
      "8.25.203.0/24",
      "27.251.211.238/32",
      "64.74.126.64/26",
      "70.39.159.0/24",
      "72.52.96.0/26",
      "89.167.131.0/24",
      "104.129.192.0/20",
      "136.226.0.0/16",
      "137.83.128.0/18",
      "147.161.128.0/17",
      "165.225.0.0/17",
      "165.225.192.0/18",
      "185.46.212.0/22",
      "199.168.148.0/22",
      "213.152.228.0/24",
      "216.218.133.192/26",
      "216.52.207.64/26",
      "156.114.2.28/32",
      "40.74.30.81/32" # <- Databricks public Ip    
    ]
  }

  storage_vars = {
    name = replace("st${include.root.locals.environment_label}", "-", "")
    tags = include.root.locals.env_variables.tags
    # To Add extra tags for the storage account of Pensions for the CDC POC which needs public access to the storage from the 
    # Azure Hosted Integration Runtime. For some reason direct access to the storage account from the self host Intergration Runtime is not possible.
    storage_account_extra_tags = try(include.root.locals.infrastructure_configuration.storage_account_extra_tags, {})

    delete_policy = {
      blob_delete_retention      = 90
      container_delete_retention = 90
    }

    network_control_allowed_subnet_ids = []
    # TODO: what should be filled in here, https://dev.azure.com/NN-Life-Pensions/NNDAP-deploy/_git/nndap-infra?path=/terraform/variables.tf hosted_agent_ip = default null ?
    network_control_allowed_ip_rules = []

    dfs_private_endpoint_ip   = "${include.root.locals.domain_variables.ip_addresses.storage_dfs_private_endpoint}"
    blob_private_endpoint_ip  = "${include.root.locals.domain_variables.ip_addresses.storage_blob_private_endpoint}"
    table_private_endpoint_ip = "${include.root.locals.domain_variables.ip_addresses.storage_table_private_endpoint}"

    add_private_link_access = true

    configure_default_network_rules = try(include.root.locals.infrastructure_configuration.configure_default_network_rules_storage, true)
    shared_access_key_enabled       = "${include.root.locals.infrastructure_configuration.storage_account.shared_access_key_enabled}"
    container_names                 = local.container_names
  }

  interface_storage_vars = (include.root.locals.infrastructure_configuration.deploy_interface_storage_account ? {
    name = replace("stint${include.root.locals.environment_label}", "-", "")
    tags = include.root.locals.env_variables.tags
    # To Add extra tags for the storage account of Pensions for the CDC POC which needs public access to the storage from the 
    # Azure Hosted Integration Runtime. For some reason direct access to the storage account from the self host Intergration Runtime is not possible.
    storage_account_extra_tags = try(include.root.locals.infrastructure_configuration.storage_account_extra_tags, {})

    delete_policy = {
      blob_delete_retention      = 90
      container_delete_retention = 90
    }

    network_control_allowed_subnet_ids = []

    # TODO: what should be filled in here, https://dev.azure.com/NN-Life-Pensions/NNDAP-deploy/_git/nndap-infra?path=/terraform/variables.tf hosted_agent_ip = default null ?
    network_control_allowed_ip_rules = []

    dfs_private_endpoint_ip  = "${include.root.locals.domain_variables.ip_addresses.interface_storage_dfs_private_endpoint}"
    blob_private_endpoint_ip = "${include.root.locals.domain_variables.ip_addresses.interface_storage_blob_private_endpoint}"

    add_private_link_access = true

    configure_default_network_rules = try(include.root.locals.infrastructure_configuration.configure_default_network_rules_storage, true)

    container_names = include.root.locals.infrastructure_configuration.interface

  } : null)

  logging_vars = {
    name                      = "log-${include.root.locals.environment_label}"
    automation_name           = "aa-${include.root.locals.environment_label}"
    data_collection_rule_name = "dcr-${include.root.locals.environment_label}"
    retention_in_days         = 90
    tags                      = include.root.locals.env_variables.tags
  }
}

# Sometimes the portal crashes because terragrunt tries multiple api calls at the same time
# This makes sure terragrunt waits 5 seconds and retries the command (max 3 times) when an error is encountered
# That is matched by the stated regex pattern
retryable_errors = [
  "(?s).*each.value*",
  "(?s).*ERROR CODE: AnotherOperationInProgress.*",
  "(?s).*ERROR: .*CanceledAndSupersededDueToAnotherOperation.*PutSubnetOperation.*",
]
