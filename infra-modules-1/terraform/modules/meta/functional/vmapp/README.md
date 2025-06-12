<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_install_cmd"></a> [app\_install\_cmd](#input\_app\_install\_cmd) | Command to install the application | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of the VM app | `string` | n/a | yes |
| <a name="input_app_remove_cmd"></a> [app\_remove\_cmd](#input\_app\_remove\_cmd) | Command to remove the application | `string` | n/a | yes |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | the version number of the app | `string` | n/a | yes |
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | Connection String of the VM Applications Storage Account | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the container for VM Applications | `string` | n/a | yes |
| <a name="input_file_name"></a> [file\_name](#input\_file\_name) | Filename of the zip file | `string` | n/a | yes |
| <a name="input_gallery_id"></a> [gallery\_id](#input\_gallery\_id) | The id of the image gallery for VM Applications | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource | `string` | `"West Europe"` | no |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | output path for zip file | `string` | n/a | yes |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | Folder containt the application files | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the storage account for VM Applications | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_version_id"></a> [app\_version\_id](#output\_app\_version\_id) | The Id of the VM Application Gallery instance |
<!-- END_TF_DOCS -->