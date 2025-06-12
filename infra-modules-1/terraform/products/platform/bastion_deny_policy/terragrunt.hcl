include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "env" {
  path = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/environments/_env/bastion_deny_policy/bastion_deny_policy.hcl"
}

