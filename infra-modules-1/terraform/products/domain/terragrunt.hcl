remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    subscription_id      = "8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b" # LPDAP-meta subscription ID
    resource_group_name  = get_env("TFSTATE_RESOURCE_GROUP_NAME")
    storage_account_name = get_env("TFSTATE_STORAGE_ACCOUNT_NAME")
    container_name       = local.container_name
    key                  = "${local.data_domain}/${path_relative_to_include()}.tfstate"
  }
  disable_dependency_optimization = false
}

#storage_use_azuread flag is required when shared key access is disabled
generate "provider_azurerm" {
  path      = "provider-azurerm.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  client_id = "${local.env_variables.client_id}"
  subscription_id = "${local.env_variables.subscription_id}"
  tenant_id = "${local.env_variables.tenant_id}"
  client_secret = var.azure_client_secret
  storage_use_azuread        = true
  
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }

    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }

    template_deployment {
      delete_nested_items_during_deletion = true
    }
  }
}

# This provider is needed when accessing resources in the meta subscription
# When no arguments are filled in (like 'client_id', 'subscription_id', etc),
# Terraform automatically looks for environment variables in the format ARM_CLIENT_ID
# So this provider uses these values.
provider "azurerm" {
  alias = "meta"
  features {}
}
EOF
}

generate "variables" {
  path      = "variables-generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "azure_client_secret" {
  type = string
  sensitive = true
}
EOF
}

# Sometimes the pipeline is not able to download the providers, for some reason.
# This makes sure that terragrunt waits 5 seconds and retries the command (max 3 times) when that error is encountered.
retryable_errors = [
  "(?s).*Error: Failed to query available provider packages*"
]

locals {
  ########### INPUT CONFIGURATION START

  # Label of the business unit
  business_unit_label = "lp"

  product_configuration = yamldecode(file(get_env("PRODUCT_CONFIGURATION_FILE")))
  env_configuration     = yamldecode(file(get_env("ENV_CONFIGURATION_FILE")))


  # These are the dependency paths used by terragrunt wrappers in _env
  dependency_paths_raw = yamldecode(file("${get_env("PRODUCT_CONFIGURATION_DIR")}/configuration/dependency_paths.yaml"))
  # We need to add the absolute root of infra-modules to each path,
  #    which creates the absolute file path to that resource
  dependency_paths = {
    for key, val in local.dependency_paths_raw.domain :
    key => format("%s/%s", get_env("TERRAGRUNT_TERRAFORM_DIR"), val)
  }

  env_variables = local.env_configuration["environment_variables"]
  # Three character representation of the current environment
  environment = local.env_variables.env_name
  # We cannot use substring as that is not supported by the Terraform version we are on
  first_letter_env = upper(regex("^(.).*", "${local.environment}")[0])

  # should be domain_variables, optional infrastructure_configuration
  domain_configuration  = local.product_configuration[local.environment]
  domain_variables_base = local.domain_configuration["domain_variables"]

  version = local.domain_configuration["domain_variables"]["version"]
  # The data_domain should be the same as the directory this file is in
  data_domain = local.domain_configuration["domain_variables"]["name"]

  # Get the list of users and parse it out.
  user_mapping = lookup(yamldecode(file("${get_env("PRODUCT_CONFIGURATION_DIR")}/configuration/user_object_mapping.yaml")), "object_ids", {})

  data_engineers   = lookup(local.domain_variables_base.object_ids, "extra_data_engineers", {})
  devops_engineers = lookup(local.domain_variables_base.object_ids, "extra_devops_engineers", {})

  data_engineers_standard   = lookup(local.product_configuration.user_object_ids, "data_engineers", {})
  devops_engineers_standard = lookup(local.env_configuration, "devops_engineers", {})

  # At this point, each key is just a name. Let's turn that into a hex key

  substituted_data_engineers = merge(
    {
      for username in local.data_engineers :
      username => local.user_mapping[username] if username != null
      }, {
      for username in local.data_engineers_standard :
      username => local.user_mapping[username] if username != null
  })
  substituted_devops_engineers = merge(
    {
      for username in local.devops_engineers :
      username => local.user_mapping[username] if username != null
      }, {
      for username in local.devops_engineers_standard :
      username => local.user_mapping[username] if username != null
  })

  # update domain variables
  updated_object_ids = merge(
    local.domain_variables_base.object_ids,
    {
      data_engineers   = local.substituted_data_engineers,
      devops_engineers = local.substituted_devops_engineers
    }
  )

  domain_variables = merge(
    local.domain_variables_base,
    {
      object_ids = local.updated_object_ids
    }
  )

  # Name of the container in which to store the tfstate file
  container_name = local.env_variables.container_name

  # 3 letter abbrevisation for the current data domain
  data_domain_short = local.domain_variables.abbreviation

  env_secrets = {
    client_secret = get_env("CLIENT_SECRET")
  }

  # Label for the current environment (example: lpcw24-dev) including the version
  environment_label = "${local.business_unit_label}${local.data_domain_short}${local.version}-${local.environment}"

  # Short label for the current environment (example: lpcw-dev) not including the version
  environment_label_short = "${local.business_unit_label}${local.data_domain_short}-${local.environment}"

  # Label for the current domain and version label
  domain_label = "${local.business_unit_label}${local.data_domain_short}${local.version}"

  # Make sure we can 'overwrite' the keys under the global infrastructure configuration with environment-specific config
  infrastructure_configuration_global_raw   = lookup(local.product_configuration, "infrastructure_configuration", {})
  infrastructure_configuration_env_specific = lookup(local.domain_configuration, "infrastructure_configuration", {})

  # Set defaults of the infrastructure_configuration
  infrastructure_configuration_global = merge(
    local.infrastructure_configuration_global_raw,
    {
      # env_type should by default be the same as the env_name
      env_type = try(local.infrastructure_configuration_global_raw.env_type, local.env_variables.env_name)
    },
    {
      # Add the Azure Hosted Integration Runtime Name to the infrastructure configuration, based on a boolean variable in the global infrastructure configuration.
      deploy_azure_hosted_integration_runtime = lookup(local.infrastructure_configuration_global_raw, "deploy_azure_hosted_integration_runtime", false)
    }
  )
  # Merge the global infrastructure configuration with the env-specific configuration
  # For conflicting keys, the values in the second map will be used. As such, we are able to overwrite global infrastructure-configuration with env-specific configuration.
  infrastructure_configuration = merge(
    local.infrastructure_configuration_global, local.infrastructure_configuration_env_specific
  )

  # Example lpdbwlpcnw01devdev
  # In predev, the volume name is lpdbwlp<domain>01pdvdev due to a limitation at the Group IT side. Hence, we need an if-statement for this edge case.
  cluster_unity_catalog_volume_name = (local.environment == "pdv") ? "${local.business_unit_label}dbw${local.business_unit_label}${local.data_domain_short}${local.version}${local.environment}dev" : "${local.business_unit_label}dbw${local.business_unit_label}${local.data_domain_short}${local.version}${local.environment}${local.environment}"
  # Example lpdwblpcnw
  cluster_unity_catalog_storage_container_name = "${local.business_unit_label}dbw${local.business_unit_label}${local.data_domain_short}"

  # The version of the infra-modules we are deploying from Artifactory. 
  # We need this to populate the version.txt Blob indiating which version is deployed for each product in each environment.
  infra_modules_version = get_env("INFRA_MODULES_VERSION")

}

inputs = {
  # Needed for the provider
  azure_client_secret = local.env_secrets.client_secret
}

# This module is only to DRY up the configuration, it doesn't define any infrastructure,
# so skip it in the run-all commands
skip = true
