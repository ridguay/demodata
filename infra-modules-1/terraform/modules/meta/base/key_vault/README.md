<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_private_endpoint"></a> [create\_private\_endpoint](#input\_create\_private\_endpoint) | When true create private endpoint for the Key Vauylt instance | `bool` | `true` | no |
| <a name="input_key_vault_enable_disk_encryption"></a> [key\_vault\_enable\_disk\_encryption](#input\_key\_vault\_enable\_disk\_encryption) | Boolean to enable disk encryption on Key Vault instance | `bool` | `false` | no |
| <a name="input_key_vault_enable_purge_protection"></a> [key\_vault\_enable\_purge\_protection](#input\_key\_vault\_enable\_purge\_protection) | Boolean to enable purge protection, which prevents you from deleting soft-deleted vaults and objects | `bool` | `true` | no |
| <a name="input_key_vault_enable_rbac_authorization"></a> [key\_vault\_enable\_rbac\_authorization](#input\_key\_vault\_enable\_rbac\_authorization) | Boolean to enable role base access control authorization on Key Vault resource | `bool` | `true` | no |
| <a name="input_key_vault_location"></a> [key\_vault\_location](#input\_key\_vault\_location) | The location of the Key Vault instancs | `string` | `"West Europe"` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Name of the Key Vault instance | `string` | n/a | yes |
| <a name="input_key_vault_private_endpoint_ip"></a> [key\_vault\_private\_endpoint\_ip](#input\_key\_vault\_private\_endpoint\_ip) | The private IP address to assign to the private endpoint | `string` | n/a | yes |
| <a name="input_key_vault_sku_name"></a> [key\_vault\_sku\_name](#input\_key\_vault\_sku\_name) | The Name of the SKU used for this Key Vault instance<br>Possible values: 'standard', 'premium' | `string` | `"standard"` | no |
| <a name="input_key_vault_soft_delete_retention_days"></a> [key\_vault\_soft\_delete\_retention\_days](#input\_key\_vault\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted<br>Min: 7, max: 90 | `number` | `90` | no |
| <a name="input_key_vault_tenant_id"></a> [key\_vault\_tenant\_id](#input\_key\_vault\_tenant\_id) | Subscription tenant id for authenticating requests to the key vault. | `string` | n/a | yes |
| <a name="input_network_control_allowed_azure_services"></a> [network\_control\_allowed\_azure\_services](#input\_network\_control\_allowed\_azure\_services) | Configure Key Vault firewall to bypass the rules and allow Azure services to access | `bool` | `false` | no |
| <a name="input_network_control_allowed_ip_rules"></a> [network\_control\_allowed\_ip\_rules](#input\_network\_control\_allowed\_ip\_rules) | (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Storage Account. | `list(string)` | `null` | no |
| <a name="input_network_control_allowed_subnet_ids"></a> [network\_control\_allowed\_subnet\_ids](#input\_network\_control\_allowed\_subnet\_ids) | Subnet resource ids which should be able to access the Key Vault | `list(string)` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The resource id of the subnet to deploy the private endpoint into | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resource Group name of the Key Vault instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the Key Vault instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | Id of Key Vault instance |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | Uri of the Key Vault instance |
<!-- END_TF_DOCS -->