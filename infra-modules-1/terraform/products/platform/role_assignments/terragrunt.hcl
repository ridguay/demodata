include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/functional/role_assignments///"
}

inputs = {
  resource_ids       = ["/subscriptions/${include.root.locals.env_variables.subscription_id}"]
  principal_id_roles = { "${include.root.locals.env_variables.iam_enterprise_object_id}" = ["Role Based Access Control Administrator", "Contributor", "User Access Administrator"] }
}
