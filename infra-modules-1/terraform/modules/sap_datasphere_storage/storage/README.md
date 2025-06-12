<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_private_link_access"></a> [add\_private\_link\_access](#input\_add\_private\_link\_access) | boolean to determine whether to create a storage account or not | `bool` | `false` | no |
| <a name="input_blob_private_endpoint_ip"></a> [blob\_private\_endpoint\_ip](#input\_blob\_private\_endpoint\_ip) | Ip of the blob private endpoint. | `string` | n/a | yes |
| <a name="input_configure_default_network_rules"></a> [configure\_default\_network\_rules](#input\_configure\_default\_network\_rules) | Boolean if you want to implement default networking rules | `bool` | `true` | no |
| <a name="input_container_names"></a> [container\_names](#input\_container\_names) | Names of the containers to be created within the storage account | `list(string)` | n/a | yes |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | Information to create a Customer Managed Key for the Storage Account instance | <pre>object({<br>    datalake_key_vault_id   = string,<br>    datalake_key_vault_name = string,<br>    key_name                = string<br>  })</pre> | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account | `bool` | `true` | no |
| <a name="input_delete_policy"></a> [delete\_policy](#input\_delete\_policy) | Specifies the number of days that the blob/container should be retained | <pre>object({<br>    blob_delete_retention      = string, # Specifies the number of days that the blob should be retained, between 1 and 365 days.<br>    container_delete_retention = string  # Specifies the number of days that the container should be retained, between 1 and 365 days.<br>  })</pre> | `null` | no |
| <a name="input_dfs_private_endpoint_ip"></a> [dfs\_private\_endpoint\_ip](#input\_dfs\_private\_endpoint\_ip) | Ip of the dfs private endpoint. | `string` | n/a | yes |
| <a name="input_network_control_allowed_ip_rules"></a> [network\_control\_allowed\_ip\_rules](#input\_network\_control\_allowed\_ip\_rules) | One or more ip addresses, or CIDR Blocks which should be able to access the Storage Account instance | `list(string)` | `null` | no |
| <a name="input_network_control_allowed_subnet_ids"></a> [network\_control\_allowed\_subnet\_ids](#input\_network\_control\_allowed\_subnet\_ids) | One or more subnet resource ids which should be able to access this Storage Account instance | `list(string)` | `null` | no |
| <a name="input_network_rules_bypasses"></a> [network\_rules\_bypasses](#input\_network\_rules\_bypasses) | Special network rules for Azure/logging services accessing ADLS. | `list(string)` | <pre>[<br>  "Logging",<br>  "Metrics",<br>  "AzureServices"<br>]</pre> | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The resource id of the subnet to deploy the private endpoint into<br>Example: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1 | `string` | n/a | yes |
| <a name="input_private_link_access_resource_id"></a> [private\_link\_access\_resource\_id](#input\_private\_link\_access\_resource\_id) | Resource id of resource to allow private link access to storage account | `string` | `null` | no |
| <a name="input_private_link_access_tenant_id"></a> [private\_link\_access\_tenant\_id](#input\_private\_link\_access\_tenant\_id) | Tenant id to use for private link access to storage account | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resource Group name of the Storage Account instance | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key | `bool` | `false` | no |
| <a name="input_storage_account_account_tier"></a> [storage\_account\_account\_tier](#input\_storage\_account\_account\_tier) | The used tier for the Storage Account instance<br>Example: {Standard,Premium} | `string` | `"Standard"` | no |
| <a name="input_storage_account_extra_tags"></a> [storage\_account\_extra\_tags](#input\_storage\_account\_extra\_tags) | Extra tags to assign to a Storage Account instance | `map(string)` | `{}` | no |
| <a name="input_storage_account_location"></a> [storage\_account\_location](#input\_storage\_account\_location) | The location of the Storage Account instance | `string` | `"West Europe"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account | `string` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | Defines the type of replication to use for the Storage Account instance<br>Possible values: {LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS} | `string` | `"ZRS"` | no |
| <a name="input_storage_management_policy"></a> [storage\_management\_policy](#input\_storage\_management\_policy) | Storage policies for hot, cool and archive data storage | <pre>object({<br>    move_to_cool_after_days = number<br>  })</pre> | <pre>{<br>  "move_to_cool_after_days": 304<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to Storage Account instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The name of the Storage Account instance |
| <a name="output_primary_dfs_endpoint"></a> [primary\_dfs\_endpoint](#output\_primary\_dfs\_endpoint) | The primary endpoint of the Distributed File System |
| <a name="output_storage_id"></a> [storage\_id](#output\_storage\_id) | The Id of the Storage Account instance |
<!-- END_TF_DOCS -->