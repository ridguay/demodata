locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/core/logging/automation///"
}

dependency "resource_group" {
  config_path = "../resource_group"

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    name = "rg-lpv000-env"
  }
}

dependency "log_analytics_workspace" {
  config_path = "../log_analytics_workspace"

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    automation_account_name = "aa-lpdap-xxx"
    name                    = "law-lpdap-xxx"
  }
}

inputs = {
  automation_account_name   = dependency.log_analytics_workspace.outputs.automation_account_name
  name                      = dependency.log_analytics_workspace.outputs.name
  automation_name           = "aa-${local.root.locals.environment_label}"
  data_collection_rule_name = "dcr-${local.root.locals.environment_label}"
  resource_group_name       = dependency.resource_group.outputs.name
  retention_in_days         = 90
  tags                      = local.root.locals.env_variables.tags
}
