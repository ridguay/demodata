<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_managed_pe_name"></a> [managed\_pe\_name](#input\_managed\_pe\_name) | The name of the ADF managed private endpoint | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the storage account to which an Azure Managed Integration Runtime should be able to connect | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->