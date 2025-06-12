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

generate "provider_azurerm" {
  path      = "provider-azurerm.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  client_id = "${local.env_variables.client_id}"
  subscription_id = "${local.env_variables.subscription_id}"
  tenant_id = "${local.env_variables.tenant_id}"
  client_secret = var.azure_client_secret

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

  platform_yaml     = yamldecode(file(get_env("PLATFORM_CONFIGURATION_FILE")))
  env_configuration = yamldecode(file(get_env("ENV_CONFIGURATION_FILE")))

  # These are the dependency paths used by terragrunt wrappers in _env
  dependency_paths_raw = yamldecode(file("${get_env("PRODUCT_CONFIGURATION_DIR")}/configuration/dependency_paths.yaml"))
  # We need to add the absolute root of infra-modules to each path,
  #    which creates the absolute file path to that resource
  dependency_paths = {
    for key, val in local.dependency_paths_raw.platform :
    key => format("%s/%s", get_env("TERRAGRUNT_TERRAFORM_DIR"), val)
  }

  env_variables = local.env_configuration["environment_variables"]
  # Three character representation of the current environment
  environment = local.env_variables.env_name

  domain_configuration  = local.platform_yaml[local.environment]
  domain_variables_base = local.domain_configuration["domain_variables"]
  domain_variables      = local.domain_variables_base

  # In this case the 'domain' is the whole platform
  # The data_domain should be the same as the directory this file is in
  data_domain = local.domain_configuration["domain_variables"]["name"]

  ########### INPUT CONFIGURATION END

  # Name of the container in which to store the tfstate file
  container_name = local.env_variables.container_name

  # 3 letter abbrevisation for the current data domain
  data_domain_short = local.domain_variables.abbreviation

  env_secrets = {
    client_secret = get_env("CLIENT_SECRET")
  }

  # Label for the current environment (example: lpcw24-dev) including the version
  environment_label = "${local.business_unit_label}${local.data_domain_short}-${local.environment}"

  # Short label for the current environment (example: lpcw-dev) not including the version
  environment_label_short = "${local.business_unit_label}${local.data_domain_short}-${local.environment}"

  # Activity Logging IAM Settings
  subscription_id  = local.env_variables.subscription_id
  iam_workspace_id = local.platform_yaml.iam_workspace_id

}

inputs = {
  # Needed for the provider
  azure_client_secret = local.env_secrets.client_secret
}


# This module is only to DRY up the configuration, it doesn't define any infrastructure,
# so skip it in the run-all commands
skip = true
