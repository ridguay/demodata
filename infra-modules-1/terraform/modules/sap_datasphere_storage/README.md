<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.114.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Region to deploy the platform to. | `string` | `"West Europe"` | no |
| <a name="input_resource_group_vars"></a> [resource\_group\_vars](#input\_resource\_group\_vars) | ## Module Specific Vars ### | <pre>object({<br>    name = string<br>    tags = optional(map(string), {})<br>  })</pre> | n/a | yes |
| <a name="input_services_subnet_vars"></a> [services\_subnet\_vars](#input\_services\_subnet\_vars) | n/a | <pre>object({<br>    subnet_name           = string<br>    subnet_address_prefix = string<br>    virtual_network_data = object({<br>      resource_group_name = string<br>      name                = string<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_storage_vars"></a> [storage\_vars](#input\_storage\_vars) | n/a | <pre>object({<br>    name                               = string<br>    tags                               = optional(map(string), {})<br>    storage_account_extra_tags         = optional(map(string), {})<br>    account_tier                       = optional(string, "Standard")<br>    replication_type                   = optional(string, "ZRS")<br>    network_control_allowed_subnet_ids = optional(list(string), null)<br>    network_control_allowed_ip_rules   = optional(list(string), null)<br>    configure_default_network_rules    = optional(bool, true)<br>    add_private_link_access            = optional(bool, false)<br>    network_rules_bypasses             = optional(list(string), ["Logging", "Metrics", "AzureServices"])<br>    delete_policy = optional(object({<br>      blob_delete_retention      = string<br>      container_delete_retention = string<br>    }), null)<br>    customer_managed_key = optional(object({<br>      datalake_key_vault_id   = string<br>      datalake_key_vault_name = string<br>      key_name                = string<br>    }), null)<br>    dfs_private_endpoint_ip  = string<br>    blob_private_endpoint_ip = string<br>    storage_management_policy = optional(<br>      object({<br>        move_to_cool_after_days = number<br>      }),<br>      {<br>        move_to_cool_after_days = 304<br>      }<br>    )<br>    container_names                 = list(string)<br>    shared_access_key_enabled       = optional(bool, false)<br>    default_to_oauth_authentication = optional(bool, true)<br>  })</pre> | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Id of the tenant to deploy the platform to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group__name"></a> [resource\_group\_\_name](#output\_resource\_group\_\_name) | n/a |
| <a name="output_storage__primary_dfs_endpoint"></a> [storage\_\_primary\_dfs\_endpoint](#output\_storage\_\_primary\_dfs\_endpoint) | n/a |
| <a name="output_storage__storage_account_id"></a> [storage\_\_storage\_account\_id](#output\_storage\_\_storage\_account\_id) | n/a |
| <a name="output_storage__storage_account_name"></a> [storage\_\_storage\_account\_name](#output\_storage\_\_storage\_account\_name) | n/a |
<!-- END_TF_DOCS -->