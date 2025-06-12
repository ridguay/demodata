locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  # BACKWARDS COMPATIBILITY: reference a dummy module when the referenced module doesn't exist.
  source = fileexists("${get_env("ARTIFACT_DIR_PATH")}/pipelines/terraform/databricks_pipeline_notebooks/main.tf") ? "${get_env("ARTIFACT_DIR_PATH")}/pipelines/terraform/databricks_pipeline_notebooks///" : "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/extensions/dummy_databricks_notebooks///"
}

dependency "base" {
  config_path = local.root.locals.dependency_paths.base

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    databricks__workspace_url = "adb-0000000000000000.00.azuredatabricks.net"
  }
}

generate "provider" {
  path      = "provider-databricks.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  host = "${dependency.base.outputs.databricks__workspace_url}"

  azure_client_id = "${local.root.locals.env_variables.client_id}"
  azure_tenant_id = "${local.root.locals.env_variables.tenant_id}"
  azure_client_secret = var.azure_client_secret
}
EOF
}

inputs = {}
