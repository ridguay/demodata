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
| <a name="input_access_connector__name"></a> [access\_connector\_\_name](#input\_access\_connector\_\_name) | Databricks Access Connector name | `string` | n/a | yes |
| <a name="input_access_connector__tags"></a> [access\_connector\_\_tags](#input\_access\_connector\_\_tags) | Tags to assign to Databricks Access Connector | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Databricks components | `string` | `"West Europe"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resource Group name of the Databricks components | `string` | n/a | yes |
| <a name="input_subnet__name"></a> [subnet\_\_name](#input\_subnet\_\_name) | The name of the subnet | `string` | n/a | yes |
| <a name="input_subnet__private_subnet_address_prefix"></a> [subnet\_\_private\_subnet\_address\_prefix](#input\_subnet\_\_private\_subnet\_address\_prefix) | Subnet private address prefix | `string` | n/a | yes |
| <a name="input_subnet__public_subnet_address_prefix"></a> [subnet\_\_public\_subnet\_address\_prefix](#input\_subnet\_\_public\_subnet\_address\_prefix) | Subnet public address prefix | `string` | n/a | yes |
| <a name="input_subnet__tags"></a> [subnet\_\_tags](#input\_subnet\_\_tags) | A mapping of tags to assign to the resources | `map(string)` | `{}` | no |
| <a name="input_subnet__virtual_network_data"></a> [subnet\_\_virtual\_network\_data](#input\_subnet\_\_virtual\_network\_data) | Information of the virtual network to retrieve its data object (usually something like name='NNANPSpoke', resource\_group\_name='AzureVnet'). | <pre>object({<br>    resource_group_name = string<br>    name                = string<br>  })</pre> | n/a | yes |
| <a name="input_workspace__managed_resource_group_name"></a> [workspace\_\_managed\_resource\_group\_name](#input\_workspace\_\_managed\_resource\_group\_name) | Databricks Workspace managed resource group name | `string` | n/a | yes |
| <a name="input_workspace__name"></a> [workspace\_\_name](#input\_workspace\_\_name) | Databricks Workspace name | `string` | n/a | yes |
| <a name="input_workspace__private_endpoint_ip"></a> [workspace\_\_private\_endpoint\_ip](#input\_workspace\_\_private\_endpoint\_ip) | Ip of the private endpoint. | `string` | n/a | yes |
| <a name="input_workspace__private_endpoint_subnet_id"></a> [workspace\_\_private\_endpoint\_subnet\_id](#input\_workspace\_\_private\_endpoint\_subnet\_id) | The subnet id to deploy the private endpoint into | `string` | n/a | yes |
| <a name="input_workspace__secure_cluster_connectivity"></a> [workspace\_\_secure\_cluster\_connectivity](#input\_workspace\_\_secure\_cluster\_connectivity) | Indicates whether the secure cluster connectivity is enabled for the Databricks Workspace instance | `bool` | `true` | no |
| <a name="input_workspace__tags"></a> [workspace\_\_tags](#input\_workspace\_\_tags) | Tags to assign to Databricks Workspace instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_access_connector_principal_id"></a> [databricks\_access\_connector\_principal\_id](#output\_databricks\_access\_connector\_principal\_id) | The principal id of the managed identity is needed to assign role. |
| <a name="output_databricks_access_connector_resource_id"></a> [databricks\_access\_connector\_resource\_id](#output\_databricks\_access\_connector\_resource\_id) | The resource id of databricks access connector. |
| <a name="output_databricks_workspace_id"></a> [databricks\_workspace\_id](#output\_databricks\_workspace\_id) | The ID of the databricks workspace instance. |
| <a name="output_databricks_workspace_url"></a> [databricks\_workspace\_url](#output\_databricks\_workspace\_url) | The URL of the databricks workspace instance. |
| <a name="output_managed_identity_principal_id"></a> [managed\_identity\_principal\_id](#output\_managed\_identity\_principal\_id) | Principal ID of the managed identity created by Databricks for the workspace |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | The private subnet id for the Databricks workspace. |
| <a name="output_private_subnet_name"></a> [private\_subnet\_name](#output\_private\_subnet\_name) | The private subnet name for the Databricks workspace. |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | The public subnet id for the Databricks workspace. |
| <a name="output_public_subnet_name"></a> [public\_subnet\_name](#output\_public\_subnet\_name) | The private subnet id for the Databricks workspace. |
<!-- END_TF_DOCS -->