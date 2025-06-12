<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_integration_runtime_name"></a> [azure\_integration\_runtime\_name](#input\_azure\_integration\_runtime\_name) | Name of the Azure hosted integration runtime | `string` | n/a | yes |
| <a name="input_cluster_spark_version"></a> [cluster\_spark\_version](#input\_cluster\_spark\_version) | Spark version of the clusters to be created within the pool<br>Only required when pool\_id is specified | `string` | `"10.4.x-scala2.12"` | no |
| <a name="input_data_factory_id"></a> [data\_factory\_id](#input\_data\_factory\_id) | The Data Factory ID in which to associate the Linked Service. Changing this forces a new resource | `string` | n/a | yes |
| <a name="input_databricks_cluster_ids"></a> [databricks\_cluster\_ids](#input\_databricks\_cluster\_ids) | A mapping of the cluster names to their ids of existing clusters within the Azure Databricks instance<br>Define exactly one of databricks\_cluster\_ids or pool\_id | `map(string)` | `{}` | no |
| <a name="input_databricks_workspace_id"></a> [databricks\_workspace\_id](#input\_databricks\_workspace\_id) | Id of the Databricks Workspace to create the ADF Databricks Linked Service to | `string` | n/a | yes |
| <a name="input_databricks_workspace_url"></a> [databricks\_workspace\_url](#input\_databricks\_workspace\_url) | The domain URL of the databricks instance. | `string` | n/a | yes |
| <a name="input_dataset_config"></a> [dataset\_config](#input\_dataset\_config) | The configuration of the datasets to be created. | <pre>list(object({<br>    dataset_name      = string<br>    container_name    = string<br>    file_type         = string<br>    compression_codec = string<br>    level             = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_integration_runtime_name"></a> [integration\_runtime\_name](#input\_integration\_runtime\_name) | Name of the Self Hosted Integration Runtime used by the Databricks Linked Service. | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Id of the Key Vault instance to create the Linked Service to | `string` | n/a | yes |
| <a name="input_legacy_clusters_enabled"></a> [legacy\_clusters\_enabled](#input\_legacy\_clusters\_enabled) | Flag to deploy legacy clusters linked services | `bool` | `true` | no |
| <a name="input_notebook_path"></a> [notebook\_path](#input\_notebook\_path) | Path to the notebook uploaded to Databricks that can run the SQL query. Should start with / and end with .py | `string` | n/a | yes |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Identifier of the instance pool within the linked Azure Databricks instance<br>Define exactly one of databricks\_cluster\_ids or pool\_id | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group containing the Virtual Machine instance | `string` | n/a | yes |
| <a name="input_storage_account_primary_dfs_endpoint"></a> [storage\_account\_primary\_dfs\_endpoint](#input\_storage\_account\_primary\_dfs\_endpoint) | Primary Distributed File System endpoint of the Storage Account instance which Azure Data Factory needs a Linked Service to | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Id of the subscription containing the virtual machine of the Self Hosted Integration Runtime | `string` | n/a | yes |
| <a name="input_user_specific_cluster_ids"></a> [user\_specific\_cluster\_ids](#input\_user\_specific\_cluster\_ids) | A mapping of the (user-specific) cluster names to their ids of existing clusters within the Azure Databricks workspace<br>Define exactly one of databricks\_cluster\_ids or pool\_id | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_name"></a> [virtual\_machine\_name](#input\_virtual\_machine\_name) | Name of the virtual machine containing the Self Hosted Integration Runtime instance | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->