<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostic_setting_name"></a> [diagnostic\_setting\_name](#input\_diagnostic\_setting\_name) | Name of the diagnostic setting | `string` | `"NNDAP_log_analytics"` | no |
| <a name="input_enabled_logs"></a> [enabled\_logs](#input\_enabled\_logs) | Configuration of the logs | `list(string)` | `[]` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Type of the log analytics workspace | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Id of the log analytics workspace | `string` | n/a | yes |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Configuration of the metrics | <pre>list(object({<br>    category = string<br>    enabled  = bool<br>  }))</pre> | `[]` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | Id of the target instance to add the diagnostic settings configuration to | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->