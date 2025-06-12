### DATA FACTORY RESOURCES ###
moved {
  from = module.data_factory.azurerm_data_factory.data_factory
  to   = module.data_factory[0].azurerm_data_factory.data_factory
}

moved {
  from = module.data_factory.azurerm_private_endpoint.data_factory
  to   = module.data_factory[0].azurerm_private_endpoint.data_factory
}

moved {
  from = module.data_factory.azurerm_data_factory_integration_runtime_self_hosted.this
  to   = module.data_factory[0].azurerm_data_factory_integration_runtime_self_hosted.adf_shir
}

moved {
  from = module.data_factory.azurerm_data_factory_managed_private_endpoint.managed_pe[0]
  to   = module.data_factory[0].azurerm_data_factory_managed_private_endpoint.managed_pe[0]
}

moved {
  from = module.data_factory.azurerm_data_factory_integration_runtime_azure.azure_ir[0]
  to   = module.data_factory[0].azurerm_data_factory_integration_runtime_azure.azure_ir[0]
}

moved {
  from = module.data_factory.azurerm_key_vault.key_vault
  to   = module.data_factory[0].azurerm_key_vault.key_vault
}

moved {
  from = module.data_factory.azurerm_private_endpoint.network
  to   = module.data_factory[0].azurerm_private_endpoint.network
}

### VM RESOURCES ###
moved {
  from = module.data_factory.random_password.admin_password
  to   = module.vm[0].random_password.admin_password
}

moved {
  from = module.data_factory.azurerm_windows_virtual_machine.vm
  to   = module.vm[0].azurerm_windows_virtual_machine.vm
}

moved {
  from = module.data_factory.azurerm_network_interface.vm
  to   = module.vm[0].azurerm_network_interface.vm
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.monitoring_agent
  to   = module.vm[0].azurerm_virtual_machine_extension.monitoring_agent
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.guest_configuration
  to   = module.vm[0].azurerm_virtual_machine_extension.guest_configuration
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.disk_encryption
  to   = module.vm[0].azurerm_virtual_machine_extension.disk_encryption
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.custom_script_gateway_install
  to   = module.vm[0].azurerm_virtual_machine_extension.custom_script_gateway_install
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.iaas_antimalware
  to   = module.vm[0].azurerm_virtual_machine_extension.iaas_antimalware
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.IaaSDiagnostics
  to   = module.vm[0].azurerm_virtual_machine_extension.IaaSDiagnostics
}

moved {
  from = module.data_factory.azurerm_monitor_data_collection_rule_association.dcra_vm
  to   = module.vm[0].azurerm_monitor_data_collection_rule_association.dcra_vm
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.ChangeTracking-Windows
  to   = module.vm[0].azurerm_virtual_machine_extension.ChangeTracking-Windows
}

moved {
  from = module.data_factory.azurerm_virtual_machine_extension.DependencyAgent-Windows
  to   = module.vm[0].azurerm_virtual_machine_extension.DependencyAgent-Windows
}

moved {
  from = module.data_factory.module.all_windows_patches_schedule
  to   = module.vm[0].module.all_windows_patches_schedule
}

moved {
  from = module.data_factory.azapi_update_resource.approval
  to   = module.approve_managed_pe_connection[0].azapi_update_resource.approval
}

moved {
  from = module.data_factory.azurerm_maintenance_configuration.patch_schedule
  to   = module.vm[0].module.all_windows_patches_schedule.azurerm_maintenance_configuration.patch_schedule
}

# ### KEY VAULT INFRA RESOURCES ###
moved {
  from = module.key_vault_infra.azurerm_key_vault.key_vault
  to   = module.key_vault_infra[0].azurerm_key_vault.key_vault
}

moved {
  from = module.key_vault_infra.azurerm_private_endpoint.network
  to   = module.key_vault_infra[0].azurerm_private_endpoint.network
}

moved {
  from = module.key_vault_infra.azurerm_key_vault_secret.secret
  to   = azurerm_key_vault_secret.secret
}

### ADF INFRA COMPONENTS ###
moved {
  from = module.adf_infra_components
  to   = module.adf_infra_components[0]
}

### DATABRICKS ###
moved {
  from = module.databricks.databricks_git_credential.ado
  to   = module.databricks[0].databricks_git_credential.ado
}

moved {
  from = module.databricks.databricks_repo.silver_transformations
  to   = module.databricks[0].databricks_repo.silver_transformations
}

moved {
  from = module.databricks.databricks_cluster.dbc
  to   = module.databricks[0].databricks_cluster.dbc
}

moved {
  from = module.databricks.databricks_library.pypi_packages
  to   = module.databricks[0].databricks_library.pypi_packages
}

moved {
  from = module.databricks.databricks_dbfs_file.dbfs_packages
  to   = module.databricks[0].databricks_dbfs_file.dbfs_packages
}

moved {
  from = module.databricks.time_sleep.wait_30_seconds
  to   = module.databricks[0].time_sleep.wait_30_seconds
}

moved {
  from = module.databricks.databricks_library.dbfs_packages
  to   = module.databricks[0].databricks_library.dbfs_packages
}

moved {
  from = module.databricks.databricks_secret_scope.scope
  to   = module.databricks[0].databricks_secret_scope.scope
}

moved {
  from = module.databricks.databricks_secret.secrets
  to   = module.databricks[0].databricks_secret.secrets
}

moved {
  from = module.databricks_service_principal.databricks_service_principal.sp
  to   = module.databricks[0].databricks_service_principal.sp
}

moved {
  from = module.databricks_service_principal.databricks_permissions.token_usage
  to   = module.databricks[0].databricks_permissions.token_usage
}

moved {
  from = module.databricks_service_principal.databricks_permissions.cluster_usage
  to   = module.databricks[0].databricks_permissions.cluster_usage
}

moved {
  from = module.databricks.azurerm_key_vault_secret.secret_meta[0]
  to   = azurerm_key_vault_secret.secret_meta[0]
}

moved {
  from = module.databricks.azurerm_key_vault_secret.secret_meta[1]
  to   = azurerm_key_vault_secret.secret_meta[1]
}


### DIAGNOSTIC SETTINGS ###
moved {
  from = module.adf_diagnostic_settings
  to   = module.adf_diagnostic_settings[0]
}

moved {
  from = module.databricks_diagnostic_settings
  to   = module.databricks_diagnostic_settings[0]
}

moved {
  from = module.disk_encryption_diagnostic_settings
  to   = module.disk_encryption_diagnostic_settings[0]
}

moved {
  from = module.kv_infra_diagnostic_settings
  to   = module.kv_infra_diagnostic_settings[0]
}

moved {
  from = module.kv_sources_diagnostic_settings
  to   = module.kv_sources_diagnostic_settings[0]
}

moved {
  from = module.storage_diagnostic_settings_blob
  to   = module.storage_diagnostic_settings["blob"]
}

moved {
  from = module.storage_diagnostic_settings_file
  to   = module.storage_diagnostic_settings["file"]
}

moved {
  from = module.storage_diagnostic_settings_queue
  to   = module.storage_diagnostic_settings["queue"]
}

moved {
  from = module.storage_diagnostic_settings_table
  to   = module.storage_diagnostic_settings["table"]
}

moved {
  from = module.databricks[0].databricks_dbfs_file.dbfs_packages
  to   = module.databricks[0].databricks_dbfs_file.legacy_dbfs_packages
}