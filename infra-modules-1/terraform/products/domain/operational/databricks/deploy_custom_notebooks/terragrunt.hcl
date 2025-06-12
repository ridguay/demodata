include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  root             = read_terragrunt_config(find_in_parent_folders())
  notebooks_exist  = fileexists("${get_env("ARTIFACT_DIR_PATH")}/logic/terraform/databricks_custom_notebooks/notebooks/dir_exist.init")
  is_mall_instance = local.root.locals.infrastructure_configuration.instance_type == "mall"
}

include "env" {
  path = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/environments/_env/databricks/deploy_logic_custom_notebooks.hcl"
}

# Skip this module if the directory doesn't exist or this is a mall instance
skip = !local.notebooks_exist || local.is_mall_instance
