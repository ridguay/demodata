<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_principal_id_roles"></a> [principal\_id\_roles](#input\_principal\_id\_roles) | Roles to add based on principal id<br>Example: { '00000000-0000-0000-0000-000000000000' = ['Data Factory Contributor'] } | `map(list(string))` | `{}` | no |
| <a name="input_resource_ids"></a> [resource\_ids](#input\_resource\_ids) | Ids of the resource to which to assign the roles to. | `list(string)` | n/a | yes |
| <a name="input_runtime_object_ids"></a> [runtime\_object\_ids](#input\_runtime\_object\_ids) | Object ids from resources that can only be determined at runtime. | `map(string)` | `{}` | no |
| <a name="input_user_principal_roles"></a> [user\_principal\_roles](#input\_user\_principal\_roles) | Roles to add based on user principal name<br>Example: { 'user@insim.biz' = ['Data Factory Contributor'] } | `map(list(string))` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->