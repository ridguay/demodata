remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    subscription_id      = "8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b" # LPDAP-meta subscription ID
    resource_group_name  = get_env("TFSTATE_RESOURCE_GROUP_NAME")
    storage_account_name = get_env("TFSTATE_STORAGE_ACCOUNT_NAME")
    container_name       = include.root.locals.container_name
    # If the environment variable "TFSTATE_DATABRICKS_CLUSTER_NAME" is set, prepend the value to the terraform statefile
    key = "${include.root.locals.data_domain}/${path_relative_to_include()}${get_env("TFSTATE_DATABRICKS_CLUSTER_NAME", "")}.tfstate"
  }
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  package_files = fileset("${get_env("ARTIFACT_DIR_PATH")}/logic/dist/", "*.whl")
  files = [for file in local.package_files : {
    file_path = "${get_env("ARTIFACT_DIR_PATH")}/logic/dist/${file}"
    dbfs_path = "/data_platform/${basename(file)}"
  }]
  root = read_terragrunt_config(find_in_parent_folders())

  cluster_name                 = get_env("TFSTATE_DATABRICKS_CLUSTER_NAME", "")
  is_empty_cluster             = local.cluster_name == ""
  is_not_empty_cluster         = !local.is_empty_cluster
  is_not_unity_catalog_cluster = length(regexall("legacy", local.cluster_name)) > 0
  is_unity_catalog_cluster     = !local.is_not_unity_catalog_cluster
  is_not_dev_env               = local.root.locals.infrastructure_configuration.env_type != "dev"
  is_mall_instance             = local.root.locals.infrastructure_configuration.instance_type == "mall"
  legacy_clusters_enabled      = local.root.locals.infrastructure_configuration.legacy_clusters_enabled
}

terraform {
  source = "${get_env("ARTIFACT_DIR_PATH")}/logic/terraform/dbfs_cluster_install///"
}

dependency "base" {
  config_path = local.root.locals.dependency_paths.base

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    databricks__workspace_url = "adb-0000000000000000.00.azuredatabricks.net"
    databricks__workspace_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-lpdapvXXX-xxx/providers/Microsoft.Databricks/workspaces/dbw-lpdapvXXX-xxx"
  }
}

dependency "functional" {
  config_path  = local.root.locals.dependency_paths.functional
  skip_outputs = local.root.locals.infrastructure_configuration.env_type != "dev"

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    databricks__user_specific_cluster_ids = {
      "cluster_load" : "0000-xxxx-0000",
      "cluster_test" : "2222-xxxx-2222",
    }
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
  files = local.files
  # When no cluster is specified, we can't use dependency.databricks_cluster.outputs.ids[..], since we don't know
  # what to fill in, and it has to be an existing key, otherwise it crashes.
  # So this if statement skips over the dependency when no cluster is specified by filling in "" as the cluster id
  cluster_id = (local.is_not_empty_cluster && local.is_not_unity_catalog_cluster) ? tostring(dependency.functional.outputs.databricks__user_specific_cluster_ids[local.cluster_name]) : ""
}

# This module is only used to deploy the package to a specific databricks cluster
# and specifically this module is for non-unity catalog clusters
# So skip this module if there is no specific cluster specified
# Also skip for mall instances, there is no package to deploy in this case
skip = local.is_not_dev_env || local.is_empty_cluster || local.is_unity_catalog_cluster || local.is_mall_instance || local.legacy_clusters_enabled
