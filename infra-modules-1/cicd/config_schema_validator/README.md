# Config Schema Validator

This script ensures the documentation of the input configuration of the infrastructure products is in sync with the actual implementation.
When a product is run, it requires input configuration in the form of yaml files.
To keep track of what key-value pairs are possible, we maintain a reference documentation (also in YAML) containing the available configuration keys and some explanation.
Each product contains such a reference document.

This script requires a path to the product, and a path to the reference documentation file.
It scrapes the product to gather all configuration keys used and compares that to the reference documentation.
It outputs keys that are present in the infrastructure implementation that are not in the reference documentation and keys that are not present in the infrastructure implementation that are present in the reference documentation.

Based on this script, the pull-request pipeline should fail if the reference documentation is not in sync.

## Schema Syntax

In the schema, all keys starting with an underscore (`_`), are disregarded. These can be used for meta information for the user, for example a description.
All other keys are regarded as part of the schema, and are included in the comparison with the infrastructure configuration.

Below is a trimmed down example of such a schema file.

```yaml
env_variables:
  tenant_id: 
    _type: "string"
    _description: "Whatever description"
  virtual_network_data:
    _description: "This key should contains resource_group_name and name."
    resource_group_name:
      _type: "string"
      _description: "Whatever description"

domain_variables:
  ip_addresses:
    databricks_public_subnet:
      _type: "string"
      _description: "Whatever description"
    databricks_private_subnet:
      _type: "string"
      _description: "Whatever description"
  virtual_machine_size:
    _type: "string"
    _description: "Whatever description"
  _abbreviation:
    _type: "string"
    _description: "Whatever description"

infrastructure_configuration:
  sync_git_repository_url:
    _type: "string"
    _description: "Whatever description"
  deploy_user_specific_clusters:
    _type: "string"
    _description: "Whatever description"
```

## Shortcomings

In the infrastructure the keys `env_variables.virtual_network_data` (module: `databricks_subnet.hcl`) and `env_variables.virtual_network_data.resource_group_name` are used.
The Databricks subnet Terraform module requies the `virtual_network_data` to contain the keys: `resource_group_name` and `name`.
But because the `env_variables.virtual_network_data.name` is never used in the infrastructure, it can't be included in the schema.

At time of writing, we use the convention to call the root Terragrunt file with the name 'root', which is what this script relies on. Terragrunt files are included using a different name, this script will skip over the configurations used from those files.

If files are referenced using square brackets: `env_variables['virtual_network_data']['whatever']`, this script will not pick up on that.

The root Terragrunt configuration contains different references to the input configuration files, namely something like `local.env_variables`. This is currently not included in the script.

If there is configuration in the infrastructure, which is commented out, but not removed. This is still parsed and considered valid configuration. Therefore we should not comment out code containing configuration.
