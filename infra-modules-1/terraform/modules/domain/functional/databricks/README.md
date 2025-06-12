<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | ~> 1.51.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster__autoterminate_after_minutes"></a> [cluster\_\_autoterminate\_after\_minutes](#input\_cluster\_\_autoterminate\_after\_minutes) | Number of minutes after which the cluster automatically terminates | `number` | `120` | no |
| <a name="input_cluster__extra_spark_configuration"></a> [cluster\_\_extra\_spark\_configuration](#input\_cluster\_\_extra\_spark\_configuration) | Extra spark configuration the cluster should have | `map(string)` | `{}` | no |
| <a name="input_cluster__legacy_clusters_enabled"></a> [cluster\_\_legacy\_clusters\_enabled](#input\_cluster\_\_legacy\_clusters\_enabled) | Flag to deploy legacy clusters | `bool` | `true` | no |
| <a name="input_cluster__maximum_workers"></a> [cluster\_\_maximum\_workers](#input\_cluster\_\_maximum\_workers) | Maximum amount of workers within the cluster | `number` | n/a | yes |
| <a name="input_cluster__minimum_workers"></a> [cluster\_\_minimum\_workers](#input\_cluster\_\_minimum\_workers) | Minimal amount of workers within the cluster | `number` | n/a | yes |
| <a name="input_cluster__names"></a> [cluster\_\_names](#input\_cluster\_\_names) | Names of the Databricks Unity Catalog enabled clusters (creates a separate cluster for each name specified) | `list(string)` | n/a | yes |
| <a name="input_cluster__node_type_id"></a> [cluster\_\_node\_type\_id](#input\_cluster\_\_node\_type\_id) | Node type ID of Databricks cluster instance | `string` | n/a | yes |
| <a name="input_cluster__pypi_packages"></a> [cluster\_\_pypi\_packages](#input\_cluster\_\_pypi\_packages) | List of packages to install on the cluster, each item should have the format 'package==x.x.x'. | `list(string)` | `[]` | no |
| <a name="input_cluster__runtime_engine"></a> [cluster\_\_runtime\_engine](#input\_cluster\_\_runtime\_engine) | The type of runtime engine to use. If not specified, the runtime engine type is inferred based on the spark\_version value. | `string` | `"STANDARD"` | no |
| <a name="input_cluster__spark_version_id"></a> [cluster\_\_spark\_version\_id](#input\_cluster\_\_spark\_version\_id) | Preloaded runtime version of Databricks cluster instance | `string` | `"10.4.x-scala2.12"` | no |
| <a name="input_cluster__tags"></a> [cluster\_\_tags](#input\_cluster\_\_tags) | Mapping of tags to assign to the Databricks cluster instance | `map(string)` | `null` | no |
| <a name="input_cluster__uc_enabled"></a> [cluster\_\_uc\_enabled](#input\_cluster\_\_uc\_enabled) | Flag to deploy UC resources | `bool` | `true` | no |
| <a name="input_cluster__unity_catalog_volume_name"></a> [cluster\_\_unity\_catalog\_volume\_name](#input\_cluster\_\_unity\_catalog\_volume\_name) | Name of the Unity Catalog volumne. | `string` | n/a | yes |
| <a name="input_cluster__unity_catalog_volume_storage_account_name"></a> [cluster\_\_unity\_catalog\_volume\_storage\_account\_name](#input\_cluster\_\_unity\_catalog\_volume\_storage\_account\_name) | Name of the storage account that contains the unity catalog volume. | `string` | n/a | yes |
| <a name="input_cluster__unity_catalog_volume_storage_container_name"></a> [cluster\_\_unity\_catalog\_volume\_storage\_container\_name](#input\_cluster\_\_unity\_catalog\_volume\_storage\_container\_name) | Name of the volume storage container that contains the unity catalog volume. | `string` | n/a | yes |
| <a name="input_env_domain"></a> [env\_domain](#input\_env\_domain) | The env-domain combination. | `string` | `""` | no |
| <a name="input_legacy_cluster__names"></a> [legacy\_cluster\_\_names](#input\_legacy\_cluster\_\_names) | Names of the Databricks clusters (creates a separate cluster for each name specified) | `list(string)` | n/a | yes |
| <a name="input_legacy_cluster__pypi_packages"></a> [legacy\_cluster\_\_pypi\_packages](#input\_legacy\_cluster\_\_pypi\_packages) | List of packages to install on the cluster, each item should have the format 'package==x.x.x'. | `list(string)` | `[]` | no |
| <a name="input_legacy_cluster__spark_version_id"></a> [legacy\_cluster\_\_spark\_version\_id](#input\_legacy\_cluster\_\_spark\_version\_id) | Preloaded runtime version of Databricks cluster instance | `string` | `"10.4.x-scala2.12"` | no |
| <a name="input_legacy_user_specific_cluster__names"></a> [legacy\_user\_specific\_cluster\_\_names](#input\_legacy\_user\_specific\_cluster\_\_names) | Names of the user-specific Databricks clusters (creates a separate cluster for each name specified) | `list(string)` | n/a | yes |
| <a name="input_meta_key_vault_id"></a> [meta\_key\_vault\_id](#input\_meta\_key\_vault\_id) | The ID of the meta key vault | `string` | n/a | yes |
| <a name="input_notebook_mounting_secret_scope"></a> [notebook\_mounting\_secret\_scope](#input\_notebook\_mounting\_secret\_scope) | Scope that gets created to save the secrets in. | `string` | n/a | yes |
| <a name="input_notebook_mounting_secrets"></a> [notebook\_mounting\_secrets](#input\_notebook\_mounting\_secrets) | Secrets to create in the scope (key = secret key, value = secret value). | `map(string)` | n/a | yes |
| <a name="input_service_principal_configuration_iam"></a> [service\_principal\_configuration\_iam](#input\_service\_principal\_configuration\_iam) | service principal list based on application\_id + cluster\_id to make it unique. <br> Example: tomap({ '42e2bbc2-4562-4982-a537-0efdd2735e73' = { <br> 'cluster\_ids' = tolist([ <br>  '0209-110110-evou14ef', ]) <br> 'display\_name' = 'LPDAP-HANA-IND-REC' }}) | <pre>object({<br>    name           = string<br>    application_id = string<br><br>  })</pre> | n/a | yes |
| <a name="input_unity_catalog_group_name"></a> [unity\_catalog\_group\_name](#input\_unity\_catalog\_group\_name) | Entra group name for unity catalog schema / volume | `string` | `""` | no |
| <a name="input_unity_catalog_sp_name"></a> [unity\_catalog\_sp\_name](#input\_unity\_catalog\_sp\_name) | Service Principal name for unity catalog schema / volume | `string` | `""` | no |
| <a name="input_user_specific_cluster__autoterminate_after_minutes"></a> [user\_specific\_cluster\_\_autoterminate\_after\_minutes](#input\_user\_specific\_cluster\_\_autoterminate\_after\_minutes) | Number of minutes after which the cluster automatically terminates | `number` | `120` | no |
| <a name="input_user_specific_cluster__extra_spark_configuration"></a> [user\_specific\_cluster\_\_extra\_spark\_configuration](#input\_user\_specific\_cluster\_\_extra\_spark\_configuration) | Extra spark configuration the cluster should have | `map(string)` | `{}` | no |
| <a name="input_user_specific_cluster__maximum_workers"></a> [user\_specific\_cluster\_\_maximum\_workers](#input\_user\_specific\_cluster\_\_maximum\_workers) | Maximum amount of workers within the cluster | `number` | n/a | yes |
| <a name="input_user_specific_cluster__minimum_workers"></a> [user\_specific\_cluster\_\_minimum\_workers](#input\_user\_specific\_cluster\_\_minimum\_workers) | Minimal amount of workers within the cluster | `number` | n/a | yes |
| <a name="input_user_specific_cluster__names"></a> [user\_specific\_cluster\_\_names](#input\_user\_specific\_cluster\_\_names) | Names of the Databricks Unity Catalog enabled clusters (creates a separate cluster for each name specified) | `list(string)` | n/a | yes |
| <a name="input_user_specific_cluster__node_type_id"></a> [user\_specific\_cluster\_\_node\_type\_id](#input\_user\_specific\_cluster\_\_node\_type\_id) | Node type ID of Databricks cluster instance | `string` | n/a | yes |
| <a name="input_user_specific_cluster__spark_version_id"></a> [user\_specific\_cluster\_\_spark\_version\_id](#input\_user\_specific\_cluster\_\_spark\_version\_id) | Preloaded runtime version of Databricks cluster instance | `string` | `"10.4.x-scala2.12"` | no |
| <a name="input_user_specific_cluster__tags"></a> [user\_specific\_cluster\_\_tags](#input\_user\_specific\_cluster\_\_tags) | Mapping of tags to assign to the Databricks cluster instance | `map(string)` | `null` | no |
| <a name="input_workspace_config__kafka_secret"></a> [workspace\_config\_\_kafka\_secret](#input\_workspace\_config\_\_kafka\_secret) | Name of the Kafka secret to retreve from the meta key vault | `string` | n/a | yes |
| <a name="input_workspace_config__nn_customer_pypi_index_url"></a> [workspace\_config\_\_nn\_customer\_pypi\_index\_url](#input\_workspace\_config\_\_nn\_customer\_pypi\_index\_url) | Additional NN PyPI index url that contains customer-specific packages, including personal access token | `string` | `"https://artifactory.insim.biz/artifactory/api/pypi/nndap-pypi/simple"` | no |
| <a name="input_workspace_config__nn_pypi_index_url"></a> [workspace\_config\_\_nn\_pypi\_index\_url](#input\_workspace\_config\_\_nn\_pypi\_index\_url) | NN PyPI index url, including personal access token | `string` | `"https://artifactory.insim.biz/artifactory/api/pypi/nn-pypi/simple"` | no |
| <a name="input_workspace_url"></a> [workspace\_url](#input\_workspace\_url) | The Databricks workspace URL | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ids"></a> [cluster\_ids](#output\_cluster\_ids) | Cluster IDs of the clusters created in this Databricks workspace. |
| <a name="output_user_specific_cluster_ids"></a> [user\_specific\_cluster\_ids](#output\_user\_specific\_cluster\_ids) | Cluster IDs of the user specific clusters created in this Databricks workspace. |
<!-- END_TF_DOCS -->