locals {
  root = read_terragrunt_config(find_in_parent_folders())
}

terraform {
  source = "${get_env("ARTIFACT_DIR_PATH")}/pipelines/terraform/data_factory_components///"
}

dependency "base" {
  config_path = local.root.locals.dependency_paths.base

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    storage__storage_account_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-lpv000-xxx/providers/Microsoft.Storage/storageAccounts/stlpv000env"
  }
}

dependency "functional" {
  config_path = local.root.locals.dependency_paths.functional

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    data_factory__shir_name = ["mock_shir"]
    data_factory__id        = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-lpdapv000-xxx/providers/Microsoft.DataFactory/factories/adf-lpdapv000-env"]
  }
}

inputs = {
  data_factory_id    = dependency.functional.outputs.data_factory__id[0]
  storage_account_id = dependency.base.outputs.storage__storage_account_id

  payload_dir_path = "${get_env("ARTIFACT_DIR_PATH")}/pipelines/payload/${local.root.locals.environment == "pdv" ? "dev" : local.root.locals.environment}"

  integration_runtime_name = dependency.functional.outputs.data_factory__shir_name[0]
}
