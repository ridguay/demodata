include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/meta/functional///"
}

dependency "base" {
  config_path = "${include.root.locals.environment_root_dir_path}/base"

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    gallery_id                          = "/subscriptions/XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/rg-lpdapv001-meta/providers/Microsoft.Compute/galleries/lpdap_gallery"
    utils_storage__storage_account_name = "dummy_storage"
    utils_storage__connection_string    = "this_is_a_connection_string"
    key_vault_iam__id                   = "/subscriptions/XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/rg-lpdapv001-meta/providers/Microsoft.KeyVault/vaults/lpdap-keyvault-iam"
    key_vault_envs__id                  = "/subscriptions/XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/rg-lpdapv001-meta/providers/Microsoft.KeyVault/vaults/lpdap-keyvault-envs"
    databricks__workspace_id            = "/subscriptions/XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/rg-lpdapv001-meta/providers/Microsoft.Databricks/workspaces/lpdap-databricks"
  }
}

locals {

}

inputs = {
  gallery_id             = dependency.base.outputs.gallery__id
  storage_account_name   = dependency.base.outputs.utility_storage__storage_account_name
  storage_container_name = "vm-applications"
  connection_string      = dependency.base.outputs.utility_storage__connection_string

  ibm_db2_driver_vars = {
    file_name       = "ibm_db2_driver.zip"
    output_path     = "ibm_db2_driver.zip"
    app_name        = "ibm_db2_driver"
    app_version     = "1.0.0"
    source_path     = "${get_repo_root()}/terraform/modules/meta/functional/vmapp/software/ibm_db2_driver"
    app_install_cmd = "rename ibm_db2_driver ibm_db2_driver.zip && mkdir c:\\packages\\ibm_db2_driver && powershell.exe -Command \"expand-Archive -path ibm_db2_driver.zip -destinationpath c:\\packages\\ibm_db2_driver; . 'c:\\Packages\\ibm_db2_driver\\install_ibm_db2_driver.ps1'\"" # This is an example how you can run a powershell script in the VM. "rename windows-cis-hardening windows2022.zip && mkdir c:\\packages\\ciswindows && powershell.exe -Command \"expand-Archive -path windows2022.zip -destinationpath c:\\packages\\ciswindows; . 'c:\\Packages\\ciswindows\\hardening.ps1'\""
    app_remove_cmd  = "powershell.exe -File \"c:\\Packages\\ibm_db2_driver\\uninstall_ibm_db2_driver.ps1\" && rmdir /S /Q C:\\packages\\ibm_db2_driver"
  }

  java_jre_vars = {
    file_name       = "java_jre.zip"
    output_path     = "java_jre.zip"
    app_name        = "java_jre"
    app_version     = "1.0.2"
    source_path     = "${get_repo_root()}/terraform/modules/meta/functional/vmapp/software/java_jre"
    app_install_cmd = "rename java_jre java_jre.zip && mkdir c:\\packages\\java_jre && powershell.exe -Command \"expand-Archive -path java_jre.zip -destinationpath c:\\packages\\java_jre; . 'c:\\Packages\\java_jre\\install_java_jre.ps1'\"" # This is a example how you can run a powershell script in the VM. "rename windows-cis-hardening windows2022.zip && mkdir c:\\packages\\ciswindows && powershell.exe -Command \"expand-Archive -path windows2022.zip -destinationpath c:\\packages\\ciswindows; . 'c:\\Packages\\ciswindows\\hardening.ps1'\""
    app_remove_cmd  = "powershell.exe -File \"c:\\Packages\\java_jre\\uninstall_java_jre.ps1\" && rmdir /S /Q C:\\packages\\java_jre"
  }

  sap_cdc_driver_vars = {
    file_name       = "sap_cdc_driver.zip"
    output_path     = "sap_cdc_driver.zip"
    app_name        = "sap_cdc_driver"
    app_version     = "1.0.1"
    source_path     = "${get_repo_root()}/terraform/modules/meta/functional/vmapp/software/sap_cdc_driver"
    app_install_cmd = "rename sap_cdc_driver sap_cdc_driver.zip && mkdir c:\\packages\\sap_cdc_driver && powershell.exe -Command \"expand-Archive -path sap_cdc_driver.zip -destinationpath c:\\packages\\sap_cdc_driver; . 'c:\\Packages\\sap_cdc_driver\\install_sap_cdc_driver.ps1'\""
    app_remove_cmd  = "powershell.exe -File \"c:\\Packages\\sap_cdc_driver\\uninstall_sap_cdc_driver.ps1\" && rmdir /S /Q C:\\packages\\sap_cdc_driver"
  }

  sap_hana_driver_vars = {
    file_name       = "sap_hana_driver.zip"
    output_path     = "sap_hana_driver.zip"
    app_name        = "sap_hana_driver"
    app_version     = "1.0.0"
    source_path     = "${get_repo_root()}/terraform/modules/meta/functional/vmapp/software/sap_hana_driver"
    app_install_cmd = "rename sap_hana_driver sap_hana_driver.zip && mkdir c:\\packages\\sap_hana_driver && powershell.exe -Command \"expand-Archive -path sap_hana_driver.zip -destinationpath c:\\packages\\sap_hana_driver; . 'c:\\Packages\\sap_hana_driver\\install_sap_hana_driver.ps1'\"" # This is a example how you can run a powershell script in the VM. "rename windows-cis-hardening windows2022.zip && mkdir c:\\packages\\ciswindows && powershell.exe -Command \"expand-Archive -path windows2022.zip -destinationpath c:\\packages\\ciswindows; . 'c:\\Packages\\ciswindows\\hardening.ps1'\""
    app_remove_cmd  = "powershell.exe -File \"c:\\Packages\\sap_hana_driver\\uninstall_sap_hana_driver.ps1\" && rmdir /S /Q C:\\packages\\sap_hana_driver"
  }

  snow_findings_vars = {
    file_name       = "snow_findings.zip"
    output_path     = "snow_findings.zip"
    app_name        = "snow_findings"
    app_version     = "1.0.3"
    source_path     = "${get_repo_root()}/terraform/modules/meta/functional/vmapp/software/snow_findings"
    app_install_cmd = "rename snow_findings snow_findings.zip && mkdir c:\\packages\\snow_findings && powershell.exe -Command \"expand-Archive -path snow_findings.zip -destinationpath c:\\packages\\snow_findings; . 'c:\\Packages\\snow_findings\\registry-settings.ps1'\"" # This is a example how you can run a powershell script in the VM. "rename windows-cis-hardening windows2022.zip && mkdir c:\\packages\\ciswindows && powershell.exe -Command \"expand-Archive -path windows2022.zip -destinationpath c:\\packages\\ciswindows; . 'c:\\Packages\\ciswindows\\hardening.ps1'\""
    app_remove_cmd  = "rmdir /S /Q C:\\packages\\snow_findings"
  }

  integration_runtime_vars = {
    file_name       = "integration_runtime.zip"
    output_path     = "integration_runtime.zip"
    app_name        = "integration_runtime"
    app_version     = "1.0.1"
    source_path     = "${get_repo_root()}/terraform/modules/meta/functional/vmapp/software/integration_runtime"
    app_install_cmd = "rename integration_runtime integration_runtime.zip && mkdir c:\\packages\\integration_runtime && powershell.exe -Command \"expand-Archive -path integration_runtime.zip -destinationpath c:\\packages\\integration_runtime; . 'c:\\Packages\\integration_runtime\\install_integration_runtime.ps1'\"" # This is a example how you can run a powershell script in the VM. "rename windows-cis-hardening windows2022.zip && mkdir c:\\packages\\ciswindows && powershell.exe -Command \"expand-Archive -path windows2022.zip -destinationpath c:\\packages\\ciswindows; . 'c:\\Packages\\ciswindows\\hardening.ps1'\""
    app_remove_cmd  = "powershell.exe -File \"c:\\Packages\\integration_runtime\\uninstall_integration_runtime.ps1\" && rmdir /S /Q C:\\packages\\integration_runtime"
  }

  key_vault_iam_role_assignments_vars = {
    key_vault_id = dependency.base.outputs.key_vault_iam__id
    principal_id_roles = merge(
      {
        for name, object_id in include.root.locals.env_variables.object_ids.devops_engineers :
        object_id => ["Reader"]
      },
      {
        for name, object_id in include.root.locals.env_variables.object_ids.devops_engineers :
        object_id => ["Key Vault Secrets Officer"]
      },
      {
        for name, object_id in include.root.locals.env_variables.object_ids.app_ids :
        object_id => ["Key Vault Secrets User"]
      }
    )
  }

  key_vault_envs_role_assignments_vars = {
    key_vault_id = dependency.base.outputs.key_vault_envs__id
    principal_id_roles = merge(
      {
        for name, object_id in include.root.locals.env_variables.object_ids.devops_engineers :
        object_id => ["Reader"]
      },
      {
        for name, object_id in include.root.locals.env_variables.object_ids.devops_engineers :
        object_id => ["Key Vault Secrets Officer"]
      },
      {
        for name, object_id in include.root.locals.env_variables.object_ids.app_ids :
        object_id => ["Key Vault Secrets User"]
      }
    )
  }

  databricks_role_assignments_vars = {
    workspace_id = dependency.base.outputs.databricks__workspace_id
    principal_id_roles = merge(
      {
        for name, object_id in include.root.locals.env_variables.object_ids.devops_engineers :
        object_id => ["Contributor"]
      },
    )
  }
}