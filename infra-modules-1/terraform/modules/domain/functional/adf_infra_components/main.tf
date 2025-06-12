# Databricks Linked Service
resource "azurerm_data_factory_linked_service_azure_databricks" "ls_adf_dbw" {
  for_each = local.all_cluster_ids

  name        = "ls_databricks_${each.key}"
  description = "Manages a Linked Service (connection via MSI) between Azure Data Factory and Azure Databricks cluster ${each.key}."

  data_factory_id            = var.data_factory_id
  adb_domain                 = "https://${var.databricks_workspace_url}"
  integration_runtime_name   = var.integration_runtime_name
  msi_work_space_resource_id = var.databricks_workspace_id
  existing_cluster_id        = each.value

  dynamic "instance_pool" {
    for_each = var.pool_id != null ? [1] : []
    content {
      instance_pool_id = var.pool_id
      cluster_version  = var.cluster_spark_version
    }
  }
}

# Manages a Linked Service (connection) between Key Vault and Azure Data Factory
resource "azurerm_data_factory_linked_service_key_vault" "ls_adf_kv" {
  name            = "ls_key_vault"
  data_factory_id = var.data_factory_id
  key_vault_id    = var.key_vault_id
}

# Run SQL Query Pipeline Resource 
resource "azurerm_data_factory_pipeline" "run_sql_query_pipeline" {
  count           = var.legacy_clusters_enabled ? 1 : 0
  name            = "cp_run_sql_query"
  data_factory_id = var.data_factory_id

  description = "Run a SQL query in Databricks."
  folder      = "manage/components"

  parameters = {
    query = ""
  }

  depends_on = [azurerm_data_factory_linked_service_azure_databricks.ls_adf_dbw["ls_databricks_cluster_load"]]

  activities_json = <<JSON
  [
    {
      "name": "Execute SQL query in Databricks",
      "type": "DatabricksNotebook",
      "dependsOn": [],
      "policy": {
        "timeout": "0.00:30:00",
        "retry": 0,
        "retryIntervalInSeconds": 30,
        "secureOutput": false,
        "secureInput": false
      },
      "userProperties": [],
      "typeProperties": {
        "notebookPath": "${var.notebook_path}",
        "baseParameters": {
          "query": {
            "value": "@pipeline().parameters.query",
            "type": "Expression"
          }
        },
        "libraries": []
      },
      "linkedServiceName": {
        "referenceName": "ls_databricks_cluster_load",
        "type": "LinkedServiceReference"
      }
    }
  ]
  JSON
}

# Start Stop VM Pipeline Resources
resource "azurerm_data_factory_pipeline" "start_and_stop_vm" {
  name            = "cp_start_or_stop_azure_vm"
  data_factory_id = var.data_factory_id

  description = "Manages the pipeline inside a Azure Data Factory instance to start or stop the virtual machine with the Self-Hosted Integration Runtime"
  folder      = "manage/components"

  parameters = {
    subscription_id     = var.subscription_id
    resource_group_name = var.resource_group_name
    vm_name             = var.virtual_machine_name
    command             = ""
  }

  activities_json = <<JSON
  [
    {
      "name": "Check Azure VM Status",
      "type": "WebActivity",
      "dependsOn": [],
      "policy": {
        "timeout": "7.00:00:00",
        "retry": 0,
        "retryIntervalInSeconds": 30,
        "secureOutput": false,
        "secureInput": false
      },
      "userProperties": [],
      "typeProperties": {
        "url": {
          "value": "@concat('https://management.azure.com/subscriptions/',pipeline().parameters.subscription_id,'/resourceGroups/',pipeline().parameters.resource_group_name,'/providers/Microsoft.Compute/virtualMachines/',pipeline().parameters.vm_name,'/InstanceView?api-version=2020-12-01')",
          "type": "Expression"
        },
        "method": "GET",
        "authentication": {
          "type": "MSI",
          "resource": "https://management.azure.com/"
        }
      }
    },
    {
      "name": "Start or Deallocate",
      "type": "IfCondition",
      "dependsOn": [
        {
          "activity": "Check Azure VM Status",
          "dependencyConditions": [
            "Succeeded"
          ]
        }
      ],
      "userProperties": [],
      "typeProperties": {
        "expression": {
          "value": "@or(and(equals(activity('Check Azure VM Status').output.statuses[1].displayStatus,'VM deallocated'), equals(pipeline().parameters.command,'Start')),and(equals(activity('Check Azure VM Status').output.statuses[1].displayStatus,'VM running'), equals(pipeline().parameters.command,'Deallocate')))",
          "type": "Expression"
        },
        "ifTrueActivities": [
          {
            "name": "Start or Pause Azure VM",
            "description": "Start or Pause Azure VM using REST APIs",
            "type": "WebActivity",
            "dependsOn": [],
            "policy": {
              "timeout": "7.00:00:00",
              "retry": 3,
              "retryIntervalInSeconds": 30,
              "secureOutput": false,
              "secureInput": false
            },
            "userProperties": [
              {
                "name": "Azure VM",
                "value": "Pause"
              }
            ],
            "typeProperties": {
              "url": {
                "value": "@concat('https://management.azure.com/subscriptions/',pipeline().parameters.subscription_id,'/resourceGroups/',pipeline().parameters.resource_group_name,'/providers/Microsoft.Compute/virtualMachines/',pipeline().parameters.vm_name,'/',pipeline().parameters.command,'?api-version=2020-12-01')",
                "type": "Expression"
              },
              "method": "POST",
              "body": {
                "value": "{}",
                "type": "Expression"
              },
              "authentication": {
                "type": "MSI",
                "resource": "https://management.azure.com/"
              }
            }
          }
        ]
      }
    }
  ]
  JSON
}

# Storage Connection
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "ls_adf_st" {
  description          = "Manages a Linked Service (connection) between Data Lake Storage Gen2 and Azure Data Factory"
  name                 = "ls_storage_account"
  data_factory_id      = var.data_factory_id
  url                  = var.storage_account_primary_dfs_endpoint
  use_managed_identity = true

  integration_runtime_name = var.integration_runtime_name
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "ls_azure_ir_st" {
  count = var.azure_integration_runtime_name != "" ? 1 : 0

  description          = "Manages a Linked Service (connection) between Data Lake Storage Gen2 and Azure Data Factory, but for an Azure Managed Integration Runtime"
  name                 = "ls_storage_account_azure_ir"
  data_factory_id      = var.data_factory_id
  url                  = var.storage_account_primary_dfs_endpoint
  use_managed_identity = true

  integration_runtime_name = var.azure_integration_runtime_name
}

resource "azurerm_data_factory_custom_dataset" "containers" {
  count           = length(var.dataset_config)
  name            = "ds_${var.dataset_config[count.index].dataset_name}"
  description     = "Manages a Dataset inside an Azure Data Factory to the ${var.dataset_config[count.index].container_name} container for ${var.dataset_config[count.index].file_type} files."
  data_factory_id = var.data_factory_id
  type            = var.dataset_config[count.index].file_type
  parameters = {
    filename  = ""
    directory = ""
  }

  type_properties_json = jsonencode(merge({
    "location" : {
      "type" : "AzureBlobFSLocation",
      "fileName" : {
        "value" : "@dataset().filename",
        "type" : "Expression"
      },
      "folderPath" : {
        "value" : "@dataset().directory",
        "type" : "Expression"
      },
      "fileSystem" : "${var.dataset_config[count.index].container_name}"
    } },
    var.dataset_config[count.index].file_type == "Parquet" ? { "compressionCodec" : "${var.dataset_config[count.index].compression_codec}" } : {},
    var.dataset_config[count.index].file_type == "Json" && var.dataset_config[count.index].compression_codec != "None" ? { "compression" : { "type" : "${var.dataset_config[count.index].compression_codec}", "level" : "${var.dataset_config[count.index].level}" } } : {},
  ))
  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.ls_adf_st.name
  }
}