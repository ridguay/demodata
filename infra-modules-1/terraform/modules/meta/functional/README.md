<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | Connection string needed to connect to the storage account. | `string` | n/a | yes |
| <a name="input_databricks_role_assignments_vars"></a> [databricks\_role\_assignments\_vars](#input\_databricks\_role\_assignments\_vars) | n/a | <pre>object({<br>    workspace_id         = string<br>    user_principal_roles = optional(map(list(string)), {})<br>    principal_id_roles   = optional(map(list(string)), {})<br>  })</pre> | `null` | no |
| <a name="input_gallery_id"></a> [gallery\_id](#input\_gallery\_id) | ID of the Azure Gallery | `string` | n/a | yes |
| <a name="input_ibm_db2_driver_vars"></a> [ibm\_db2\_driver\_vars](#input\_ibm\_db2\_driver\_vars) | n/a | <pre>object({<br>    file_name       = string<br>    output_path     = string<br>    app_name        = string<br>    app_version     = string<br>    source_path     = string<br>    app_install_cmd = string<br>    app_remove_cmd  = string<br>  })</pre> | n/a | yes |
| <a name="input_integration_runtime_vars"></a> [integration\_runtime\_vars](#input\_integration\_runtime\_vars) | n/a | <pre>object({<br>    file_name       = string<br>    output_path     = string<br>    app_name        = string<br>    app_version     = string<br>    source_path     = string<br>    app_install_cmd = string<br>    app_remove_cmd  = string<br>  })</pre> | n/a | yes |
| <a name="input_java_jre_vars"></a> [java\_jre\_vars](#input\_java\_jre\_vars) | n/a | <pre>object({<br>    file_name       = string<br>    output_path     = string<br>    app_name        = string<br>    app_version     = string<br>    source_path     = string<br>    app_install_cmd = string<br>    app_remove_cmd  = string<br>  })</pre> | n/a | yes |
| <a name="input_key_vault_envs_role_assignments_vars"></a> [key\_vault\_envs\_role\_assignments\_vars](#input\_key\_vault\_envs\_role\_assignments\_vars) | n/a | <pre>object({<br>    key_vault_id         = string<br>    user_principal_roles = optional(map(list(string)), {})<br>    principal_id_roles   = optional(map(list(string)), {})<br>  })</pre> | `null` | no |
| <a name="input_key_vault_iam_role_assignments_vars"></a> [key\_vault\_iam\_role\_assignments\_vars](#input\_key\_vault\_iam\_role\_assignments\_vars) | n/a | <pre>object({<br>    key_vault_id         = string<br>    user_principal_roles = optional(map(list(string)), {})<br>    principal_id_roles   = optional(map(list(string)), {})<br>  })</pre> | `null` | no |
| <a name="input_sap_cdc_driver_vars"></a> [sap\_cdc\_driver\_vars](#input\_sap\_cdc\_driver\_vars) | n/a | <pre>object({<br>    file_name       = string<br>    output_path     = string<br>    app_name        = string<br>    app_version     = string<br>    source_path     = string<br>    app_install_cmd = string<br>    app_remove_cmd  = string<br>  })</pre> | n/a | yes |
| <a name="input_sap_hana_driver_vars"></a> [sap\_hana\_driver\_vars](#input\_sap\_hana\_driver\_vars) | n/a | <pre>object({<br>    file_name       = string<br>    output_path     = string<br>    app_name        = string<br>    app_version     = string<br>    source_path     = string<br>    app_install_cmd = string<br>    app_remove_cmd  = string<br>  })</pre> | n/a | yes |
| <a name="input_snow_findings_vars"></a> [snow\_findings\_vars](#input\_snow\_findings\_vars) | n/a | <pre>object({<br>    file_name       = string<br>    output_path     = string<br>    app_name        = string<br>    app_version     = string<br>    source_path     = string<br>    app_install_cmd = string<br>    app_remove_cmd  = string<br>  })</pre> | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account in which the driver files reside. | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | The name of the storage container in which the VM Apps should be stored. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->