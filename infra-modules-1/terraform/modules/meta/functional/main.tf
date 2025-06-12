module "ibm_db2_driver" {
  source = "./vmapp"

  gallery_id           = var.gallery_id
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
  connection_string    = var.connection_string

  file_name       = var.ibm_db2_driver_vars.file_name
  output_path     = var.ibm_db2_driver_vars.output_path
  app_name        = var.ibm_db2_driver_vars.app_name
  app_version     = var.ibm_db2_driver_vars.app_version
  source_path     = var.ibm_db2_driver_vars.source_path
  app_install_cmd = var.ibm_db2_driver_vars.app_install_cmd
  app_remove_cmd  = var.ibm_db2_driver_vars.app_remove_cmd
}

module "java_jre" {
  source = "./vmapp"

  gallery_id           = var.gallery_id
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
  connection_string    = var.connection_string

  file_name       = var.java_jre_vars.file_name
  output_path     = var.java_jre_vars.output_path
  app_name        = var.java_jre_vars.app_name
  app_version     = var.java_jre_vars.app_version
  source_path     = var.java_jre_vars.source_path
  app_install_cmd = var.java_jre_vars.app_install_cmd
  app_remove_cmd  = var.java_jre_vars.app_remove_cmd
}

module "sap_cdc_driver" {
  source = "./vmapp"

  gallery_id           = var.gallery_id
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
  connection_string    = var.connection_string

  file_name       = var.sap_cdc_driver_vars.file_name
  output_path     = var.sap_cdc_driver_vars.output_path
  app_name        = var.sap_cdc_driver_vars.app_name
  app_version     = var.sap_cdc_driver_vars.app_version
  source_path     = var.sap_cdc_driver_vars.source_path
  app_install_cmd = var.sap_cdc_driver_vars.app_install_cmd
  app_remove_cmd  = var.sap_cdc_driver_vars.app_remove_cmd
}

module "sap_hana_driver" {
  source = "./vmapp"

  gallery_id           = var.gallery_id
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
  connection_string    = var.connection_string

  file_name       = var.sap_hana_driver_vars.file_name
  output_path     = var.sap_hana_driver_vars.output_path
  app_name        = var.sap_hana_driver_vars.app_name
  app_version     = var.sap_hana_driver_vars.app_version
  source_path     = var.sap_hana_driver_vars.source_path
  app_install_cmd = var.sap_hana_driver_vars.app_install_cmd
  app_remove_cmd  = var.sap_hana_driver_vars.app_remove_cmd
}

module "snow_findings" {
  source = "./vmapp"

  gallery_id           = var.gallery_id
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
  connection_string    = var.connection_string

  file_name       = var.snow_findings_vars.file_name
  output_path     = var.snow_findings_vars.output_path
  app_name        = var.snow_findings_vars.app_name
  app_version     = var.snow_findings_vars.app_version
  source_path     = var.snow_findings_vars.source_path
  app_install_cmd = var.snow_findings_vars.app_install_cmd
  app_remove_cmd  = var.snow_findings_vars.app_remove_cmd
}

module "integration_runtime" {
  source = "./vmapp"

  gallery_id           = var.gallery_id
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
  connection_string    = var.connection_string

  file_name       = var.integration_runtime_vars.file_name
  output_path     = var.integration_runtime_vars.output_path
  app_name        = var.integration_runtime_vars.app_name
  app_version     = var.integration_runtime_vars.app_version
  source_path     = var.integration_runtime_vars.source_path
  app_install_cmd = var.integration_runtime_vars.app_install_cmd
  app_remove_cmd  = var.integration_runtime_vars.app_remove_cmd
}


module "key_vault_iam_role_assignments" {
  source = "./role_assignments"

  count = var.key_vault_iam_role_assignments_vars == null ? 0 : 1

  resource_ids         = [var.key_vault_iam_role_assignments_vars.key_vault_id]
  user_principal_roles = var.key_vault_iam_role_assignments_vars.user_principal_roles
  principal_id_roles   = var.key_vault_iam_role_assignments_vars.principal_id_roles
}

module "key_vault_envs_role_assignments" {
  source = "./role_assignments"

  count = var.key_vault_envs_role_assignments_vars == null ? 0 : 1

  resource_ids         = [var.key_vault_envs_role_assignments_vars.key_vault_id]
  user_principal_roles = var.key_vault_envs_role_assignments_vars.user_principal_roles
  principal_id_roles   = var.key_vault_envs_role_assignments_vars.principal_id_roles
}

module "databricks_role_assignments" {
  source = "./role_assignments"

  count = var.databricks_role_assignments_vars == null ? 0 : 1

  resource_ids         = [var.databricks_role_assignments_vars.workspace_id]
  user_principal_roles = var.databricks_role_assignments_vars.user_principal_roles
  principal_id_roles   = var.databricks_role_assignments_vars.principal_id_roles
}