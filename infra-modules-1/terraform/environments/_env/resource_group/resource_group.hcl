locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/core/resource_group///"
}

inputs = {
  name = "rg-${local.root.locals.environment_label}"
  tags = local.root.locals.env_variables.tags
}
