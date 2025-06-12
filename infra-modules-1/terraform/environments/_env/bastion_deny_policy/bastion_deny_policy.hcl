locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/core/bastion_deny_policy///"
}


inputs = {
  subscription_id = "${local.root.locals.env_variables.subscription_id}"
}
