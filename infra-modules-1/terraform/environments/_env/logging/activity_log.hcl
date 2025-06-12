locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/core/logging/activity_log///"
}

inputs = {
  # local.root.locals.env_variables.tags
  subscription_id  = local.root.locals.subscription_id
  iam_workspace_id = local.root.locals.iam_workspace_id
}
