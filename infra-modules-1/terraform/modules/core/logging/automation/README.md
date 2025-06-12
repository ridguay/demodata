<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | Name of the Automation Account | `string` | n/a | yes |
| <a name="input_automation_name"></a> [automation\_name](#input\_automation\_name) | Log Analytics Workspace Automation name | `string` | n/a | yes |
| <a name="input_data_collection_rule_name"></a> [data\_collection\_rule\_name](#input\_data\_collection\_rule\_name) | Log Analytics Workspace Data Collection Rule name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Log Analytics Workspace instance name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Log Analytics Workspace data retention in days<br>Possible values: 7 or range between 30 and 730 | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the Low Analytics Workspace instance | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->