<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blob_folder"></a> [blob\_folder](#input\_blob\_folder) | Folder in which the version.txt blob should be placed. | `string` | n/a | yes |
| <a name="input_infra_modules_version"></a> [infra\_modules\_version](#input\_infra\_modules\_version) | Version number of the infra-modules artifact we are deploying. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Storage account (metatfstate) to deploy the version blob to. | `string` | `"West Europe"` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Storage container to deploy the version blob to. | `string` | `"West Europe"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->