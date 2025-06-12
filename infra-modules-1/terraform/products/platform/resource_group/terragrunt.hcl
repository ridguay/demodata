include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "env" {
  path = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/environments/_env/resource_group/resource_group.hcl"
}

