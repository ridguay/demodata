locals {
  root = read_terragrunt_config(find_in_parent_folders())

  package_files = fileset("${get_env("ARTIFACT_DIR_PATH")}/logic/dist/", "*.whl")
  files = [for file in local.package_files : {
    file_path   = "${get_env("ARTIFACT_DIR_PATH")}/logic/dist/${file}"
    volume_path = "/Volumes/${local.root.locals.cluster_unity_catalog_volume_name}/lpdap_databricks_cluster/cluster_packages/packages/${basename(file)}"
  }]
}

terraform {
  source = "${get_env("ARTIFACT_DIR_PATH")}/logic/terraform/cluster_libraries///"
}

dependency "base" {
  config_path = local.root.locals.dependency_paths.base

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    databricks_workspace_url = "adb-0000000000000000.00.azuredatabricks.net"
    databricks_workspace_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-lpdapvXXX-xxx/providers/Microsoft.Databricks/workspaces/dbw-lpdapvXXX-xxx"
  }
}

dependency "functional" {
  config_path = local.root.locals.dependency_paths.functional

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    databricks__cluster_ids = { "cluster_load" : "0000-xxxx-0000" }
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

inputs = {
  files      = local.files
  cluster_id = local.root.locals.infrastructure_configuration.uc_enabled ? dependency.functional.outputs.databricks__cluster_ids.cluster_main : ""
}


