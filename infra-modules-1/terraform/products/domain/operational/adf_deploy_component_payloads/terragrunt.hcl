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
    container_name       = include.root.locals.container_name
    # If the environment variable "TFSTATE_DATA_SOURCE_NAME" is set, prepend the value to the terraform statefile
    key = "${include.root.locals.data_domain}/${path_relative_to_include("root")}${include.root.locals.infrastructure_configuration.env_type == "dev" ? get_env("TFSTATE_DATA_SOURCE_NAME", "") : ""}.tfstate"
  }
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "env" {
  path = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/environments/_env/data_factory/component_payloads.hcl"
}

locals {
  root             = read_terragrunt_config(find_in_parent_folders())
  is_mall_instance = local.root.locals.infrastructure_configuration.instance_type == "mall"
}

# In the dev environment, this module should only execute when the data source name is set.
# In all other environments, this module should always execute.
# So the module is skipped when the platform type is dev and the variable is not set.
skip = (
  local.is_mall_instance || (
    (include.root.locals.infrastructure_configuration.env_type == "dev") &&
  (get_env("TFSTATE_DATA_SOURCE_NAME", "") == ""))
)

retryable_errors = [
  "(?s).*each.value*"
]
