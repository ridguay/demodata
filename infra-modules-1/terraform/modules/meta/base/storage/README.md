<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow public access on the storage account | `bool` | `false` | no |
| <a name="input_blob_private_endpoint_ip"></a> [blob\_private\_endpoint\_ip](#input\_blob\_private\_endpoint\_ip) | The IP for the blob-targeted private endpoint | `string` | `null` | no |
| <a name="input_container_access"></a> [container\_access](#input\_container\_access) | Type of access for the container | `string` | `"private"` | no |
| <a name="input_container_names"></a> [container\_names](#input\_container\_names) | The names of the storage containers | `list(string)` | n/a | yes |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account | `bool` | `true` | no |
| <a name="input_delete_policy"></a> [delete\_policy](#input\_delete\_policy) | Specifies the number of days that the blob/container should be retained | <pre>object({<br>    blob_delete_retention      = string, # Specifies the number of days that the blob should be retained, between 1 and 365 days.<br>    container_delete_retention = string  # Specifies the number of days that the container should be retained, between 1 and 365 days.<br>  })</pre> | `null` | no |
| <a name="input_deploy_storage_account"></a> [deploy\_storage\_account](#input\_deploy\_storage\_account) | Boolean to decide whether or not to deploy a storage account. | `bool` | `true` | no |
| <a name="input_dfs_private_endpoint_ip"></a> [dfs\_private\_endpoint\_ip](#input\_dfs\_private\_endpoint\_ip) | The IP for the dfs-targeted private endpoint | `string` | `null` | no |
| <a name="input_enabled_from_all_networks"></a> [enabled\_from\_all\_networks](#input\_enabled\_from\_all\_networks) | Enable public network access for the storage account, (you also need to put var.public\_network\_access\_enabled to `true`). This is not allowed, only when you have an approval of your BSO.(https://making.nn.nl/spaces/cloud/azure-cloud-platform/platform/security-compliance/azure-policies/exemptions-on-enforced-azure-policies/) | `string` | `"Deny"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region of the meta resource group | `string` | `"West Europe"` | no |
| <a name="input_network_control_allowed_ip_rules"></a> [network\_control\_allowed\_ip\_rules](#input\_network\_control\_allowed\_ip\_rules) | One or more ip addresses, or CIDR Blocks which should be able to access the Storage Account instance | `list(string)` | `null` | no |
| <a name="input_network_control_allowed_subnet_ids"></a> [network\_control\_allowed\_subnet\_ids](#input\_network\_control\_allowed\_subnet\_ids) | One or more subnet resource ids which should be able to access this Storage Account instance | `list(string)` | `null` | no |
| <a name="input_network_rules_bypasses"></a> [network\_rules\_bypasses](#input\_network\_rules\_bypasses) | Special network rules for Azure/logging services accessing ADLS. | `list(string)` | <pre>[<br>  "Logging",<br>  "Metrics",<br>  "AzureServices"<br>]</pre> | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The ID of the subnet in which the private endpoint should be | `string` | n/a | yes |
| <a name="input_private_link_access_resource_id"></a> [private\_link\_access\_resource\_id](#input\_private\_link\_access\_resource\_id) | Resource id of resource to allow private link access to storage account | `string` | `null` | no |
| <a name="input_private_link_access_tenant_id"></a> [private\_link\_access\_tenant\_id](#input\_private\_link\_access\_tenant\_id) | Tenant id to use for private link access to storage account | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the public network access is enabled | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the meta resource group | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key | `bool` | `false` | no |
| <a name="input_storage_account_account_tier"></a> [storage\_account\_account\_tier](#input\_storage\_account\_account\_tier) | The used tier for the Storage Account instance<br>Example: {Standard,Premium} | `string` | `"Standard"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account that needs to be deployed. If empty, there already exists a storage account. | `string` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | Defines the type of replication to use for the Storage Account instance<br>Possible values: {LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS} | `string` | `"ZRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The access key of the Storage Account instance |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the utility storage account. |
<!-- END_TF_DOCS -->