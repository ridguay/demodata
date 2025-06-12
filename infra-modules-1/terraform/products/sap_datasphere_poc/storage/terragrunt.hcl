include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/sap_datasphere_storage///"
}

locals {
  container_names = ["sapdata"]
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

  storage_vars = {
    name                       = replace("st${include.root.locals.environment_label}", "-", "")
    tags                       = include.root.locals.env_variables.tags
    storage_account_extra_tags = try(include.root.locals.infrastructure_configuration.storage_account.storage_account_extra_tags, {})

    delete_policy = {
      blob_delete_retention      = 90
      container_delete_retention = 90
    }

    network_control_allowed_subnet_ids = ["/subscriptions/168f9505-2f53-4443-adc0-5ea4ce7f1378/resourceGroups/dis-fjh12/providers/Microsoft.Network/virtualNetworks/dis-fjh12/subnets/shoot--di-eu20--dis-fjh12-nodes"]

    # TODO: what should be filled in here, https://dev.azure.com/NN-Life-Pensions/NNDAP-deploy/_git/nndap-infra?path=/terraform/variables.tf hosted_agent_ip = default null ?
    network_control_allowed_ip_rules = []

    dfs_private_endpoint_ip  = "${include.root.locals.domain_variables.ip_addresses.storage_dfs_private_endpoint}"
    blob_private_endpoint_ip = "${include.root.locals.domain_variables.ip_addresses.storage_blob_private_endpoint}"

    add_private_link_access = true

    configure_default_network_rules = try(include.root.locals.infrastructure_configuration.storage_account.configure_default_network_rules_storage, true)

    shared_access_key_enabled       = "${include.root.locals.infrastructure_configuration.storage_account.shared_access_key_enabled}"
    default_to_oauth_authentication = "${include.root.locals.infrastructure_configuration.storage_account.default_to_oauth_authentication}"

    container_names = local.container_names
  }

}

# Sometimes the portal crashes because terragrunt tries multiple api calls at the same time
# This makes sure terragrunt waits 5 seconds and retries the command (max 3 times) when an error is encountered
# That is matched by the stated regex pattern
retryable_errors = [
  "(?s).*ERROR: .*CanceledAndSupersededDueToAnotherOperation.*PutSubnetOperation.*",
]
