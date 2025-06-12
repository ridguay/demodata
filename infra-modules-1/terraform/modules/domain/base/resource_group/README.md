<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Location of the Resource Group instance | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Resource Group instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the Resource Group | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Id of the Resource Group instance |
| <a name="output_name"></a> [name](#output\_name) | The name of the Resource Group instance |
<!-- END_TF_DOCS -->