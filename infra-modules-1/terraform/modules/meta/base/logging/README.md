<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_name"></a> [automation\_name](#input\_automation\_name) | Log Analytics Workspace Automation name | `string` | n/a | yes |
| <a name="input_data_collection_rule_name"></a> [data\_collection\_rule\_name](#input\_data\_collection\_rule\_name) | Log Analytics Workspace Data Collection Rule name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Log Analytics Workspace instance name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Log Analytics Workspace data retention in days<br>Possible values: 7 or range between 30 and 730 | `number` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Id of the Azure subscription | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the Low Analytics Workspace instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_automation_account_name"></a> [automation\_account\_name](#output\_automation\_account\_name) | The name of the Automation Account |
| <a name="output_id"></a> [id](#output\_id) | The id of the Log Analytics Workspace |
| <a name="output_law_data_collection_rule_id"></a> [law\_data\_collection\_rule\_id](#output\_law\_data\_collection\_rule\_id) | The id of the Data Collection Rule for Windows VM's |
| <a name="output_name"></a> [name](#output\_name) | The name of the Log Analytics Workspace |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The primary shared key of the Log Analytics Workspace |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The workspace id of the Log Analytics Workspace |
<!-- END_TF_DOCS -->