include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "env" {
  path = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/environments/_env/databricks/deploy_library.hcl"
}

locals {
  root             = read_terragrunt_config(find_in_parent_folders())
  is_mall_instance = local.root.locals.infrastructure_configuration.instance_type == "mall"
}

skip = (!local.root.locals.infrastructure_configuration.uc_enabled || local.is_mall_instance)
