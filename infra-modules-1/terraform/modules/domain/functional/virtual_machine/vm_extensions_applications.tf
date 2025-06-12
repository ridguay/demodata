# VM Monitoring
# Schema: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/oms-windows#extension-schema
resource "azurerm_virtual_machine_extension" "monitoring_agent" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  name               = "MicrosoftMonitoringAgent"
  tags               = var.tags

  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId": "${var.monitoring_agent_config.log_analytics_workspace_workspace_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${var.monitoring_agent_config.log_analytics_workspace_auth_key}"
    }
  PROTECTED_SETTINGS
}

# VM Policy
# Schema: https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/guest-configuration#terraform
resource "azurerm_virtual_machine_extension" "guest_configuration" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  name               = "AzurePolicyforWindows"
  tags               = var.tags

  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  depends_on = [
    azurerm_virtual_machine_extension.monitoring_agent
  ]
}

# VM Encryption
# Schema: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/azure-disk-enc-windows#schema-v22-no-aad-recommended
resource "azurerm_virtual_machine_extension" "disk_encryption" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  name               = "AzureDiskEncryption"
  tags               = var.tags

  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryption"
  type_handler_version       = "2.2"
  auto_upgrade_minor_version = true


  settings = <<SETTINGS
    {
      "EncryptionOperation": "EnableEncryption",
      "KeyVaultURL": "${var.shir_key_vault_uri}",
      "KeyVaultResourceId": "${var.shir_key_vault_id}",
      "KeyEncryptionAlgorithm": "RSA-OAEP-256",
      "VolumeType": "All"
    }
SETTINGS


  depends_on = [
    azurerm_virtual_machine_extension.guest_configuration
  ]
}

# VM Integration Runtime Installation
# Schema: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows#extension-schema
resource "azurerm_virtual_machine_extension" "custom_script_shir_install" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  name               = "SHIRInstall"
  tags               = var.tags

  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  # NOTE 1: Since the VM has no internet access, the script is in-lined. Sadly, a Windows command
  #         is limited to 8191 characters. Therefore the script is gzipped and base64 encoded.
  #         Source: https://docs.microsoft.com/en-us/troubleshoot/windows-client/shell-experience/command-line-string-limitation#more-information
  # NOTE 2: Script is executed from a cmd-shell, therefore escape " as \".
  #         Second, since value is json-encoded, escape \" as \\\".
  settings = <<SETTINGS
    {
      "fileUris": ["https://stlpdapv001metautils.blob.core.windows.net/vm-scripts/vm_custom_data.ps1",
                   "https://stlpdapv001metautils.blob.core.windows.net/drivers/integration_runtime.zip"
      ],
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File vm_custom_data.ps1 -authKey \"${var.shir_authorization_key}\" -dfHost \"${var.adf_private_endpoint_fqdn}\" -dfIP \"${var.adf_private_endpoint_ip_address}\""
    }

SETTINGS

  depends_on = [
    azurerm_virtual_machine_extension.disk_encryption
  ]
}

# VM Endpoint Protection/Antimalware
# Schema: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/iaas-antimalware-windows
resource "azurerm_virtual_machine_extension" "iaas_antimalware" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  name               = "MicrosoftAntimalware"
  tags               = var.tags

  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "AntimalwareEnabled": "true",
      "RealtimeProtectionEnabled": "true",
      "ScheduledScanSettings": {
        "isEnabled": "true"
      }
    }
SETTINGS

  depends_on = [
    azurerm_virtual_machine_extension.custom_script_shir_install
  ]
}

# Enable Vm diagnostics Settings
resource "azurerm_virtual_machine_extension" "IaaSDiagnostics" {
  count = var.diagnostics_storage_account_name != null ? 1 : 0

  name                       = "VmDiagnosticsSettings"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "IaaSDiagnostics"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = true

  settings           = <<SETTINGS
    {
      "StorageAccount": "${var.diagnostics_storage_account_name}",
      "WadCfg": {
        "DiagnosticMonitorConfiguration": {
          "DiagnosticInfrastructureLogs": {
             "scheduledTransferLogLevelFilter": "Error",
             "scheduledTransferPeriod": "PT1M"
            },
          "WindowsEventLog": {
             "scheduledTransferPeriod": "PT1M",
             "DataSource": [
                  {
                      "name": "Application!*[System[(Level=1 or Level=2 or Level=3)]]"
                  },
                  {
                      "name": "System!*[System[(Level=1 or Level=2 or Level=3)]]"
                  },
                  {
                      "name": "Security!*[System[(band(Keywords,4503599627370496))]]"
                  }
                            ]
                  },
        "overallQuotaInMB": 8192
        }
      }
    }
SETTINGS
  protected_settings = <<SETTINGS
    {
        "storageAccountName": "${var.diagnostics_storage_account_name}"
    }
SETTINGS

  depends_on = [
    azurerm_virtual_machine_extension.iaas_antimalware
  ]

}

resource "azurerm_monitor_data_collection_rule_association" "dcra_vm" {
  name                    = "dcra-windows-vm"
  target_resource_id      = azurerm_windows_virtual_machine.vm.id
  data_collection_rule_id = var.law_data_collection_rule_id
  description             = "Data collection Rule Association"
}

resource "azurerm_virtual_machine_extension" "DependencyAgent-Windows" {
  name                       = "DependencyAgentWindows"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.10"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  depends_on = [
    azurerm_virtual_machine_extension.iaas_antimalware
  ]
}

module "all_windows_patches_schedule" {
  source  = "artifactory.insim.biz/azure-cloud-features-terraform__azure-tf-mod-patch-schedule/schedule/azure"
  version = "1.0.6" # Update the version as needed

  resource_group_name                = var.resource_group_name
  schedule_name                      = var.vm_patch.schedule_name
  start_time                         = var.vm_patch.start_time
  start_date                         = var.vm_patch.start_date
  recur_every                        = var.vm_patch.recur_every
  duration                           = var.vm_patch.duration
  windows_classifications_to_include = ["Critical", "Security", "UpdateRollup", "FeaturePack", "ServicePack", "Definition", "Tools", "Updates"]
}
