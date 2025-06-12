remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    subscription_id      = "8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b" # meta subscription ID
    resource_group_name  = "rg-${local.environment_label}"
    storage_account_name = replace("st${local.environment_label}tfstate", "-", "")
    container_name       = "meta"
    key                  = "${path_relative_to_include()}.tfstate"
  }
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
  }
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

locals {
  business_unit_label = "lpdap"
  environment         = "meta"
  version             = "001"

  env_variables = yamldecode(file("environment.yaml"))
  env_secrets   = yamldecode(file("secrets.yaml"))

  # Label for the current environment (example: lpdapv024-dev)
  environment_label = "${local.business_unit_label}v${local.version}-${local.environment}"
  subscription_id   = "/subscriptions/${local.env_variables.subscription_id}"

  # Provider_files = find_in_parent_folders("required-providers-*.txt")
  environment_root_dir_path = "${get_repo_root()}/terraform/products/meta"

  # IAM Logging variables
  iam_environment_label           = "${local.business_unit_label}-logging-iam"
  iam_logging_resource_group_name = "rg-${local.iam_environment_label}"
  iam_logging_workpspace_name     = "log-${local.business_unit_label}-iam"
  iam_databricks_storage_account  = "stlpdaploggingiam"
}

inputs = {
  azure_client_secret = local.env_secrets.client_secret
}

# This module is only to DRY up the configuration, it doesn't define any infrastructure,
# so skip it in the run-all commands
skip = true
