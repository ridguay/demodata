locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  # BACKWARDS COMPATIBILITY: reference the new module path if it exists, otherwise use the 'old' module path.
  source = fileexists("${get_env("ARTIFACT_DIR_PATH")}/pipelines/terraform/databricks_logic_notebooks/main.tf") ? "${get_env("ARTIFACT_DIR_PATH")}/pipelines/terraform/databricks_logic_notebooks///" : "${get_env("ARTIFACT_DIR_PATH")}/logic/terraform/databricks_notebooks///"
}

dependency "base" {
  config_path = local.root.locals.dependency_paths.base

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    databricks_workspace_url = "adb-0000000000000000.00.azuredatabricks.net"
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

# TODO ???
# BACKWARDS COMPATIBILITY: The later modules don't need any inputs, so, this is here only for backwards compatibility
inputs = {
  notebooks = [
    {
      notebook_path     = "/run_notebook.py"
      notebook_language = "PYTHON"
      file_path         = "${get_env("ARTIFACT_DIR_PATH")}/logic/src/run_notebook.py"
    },
    {
      notebook_path     = "/query_databricks.py"
      notebook_language = "PYTHON"
      file_path         = "${get_env("ARTIFACT_DIR_PATH")}/logic/src/query_databricks.py"
    }
  ]
}
