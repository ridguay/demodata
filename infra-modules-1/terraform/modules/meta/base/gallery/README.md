<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gallery_name"></a> [gallery\_name](#input\_gallery\_name) | Name of the VM Application Gallery | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the VM App Gallery | `string` | `"West Europe"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to Storage Account instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gallery_id"></a> [gallery\_id](#output\_gallery\_id) | The Id of the VM Application Gallery instance |
<!-- END_TF_DOCS -->