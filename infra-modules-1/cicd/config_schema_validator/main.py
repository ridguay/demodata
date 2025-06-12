import typer
from product_configurations import ProductConfigurations
from product_schema import ProductSchema
from dict_utils import deep_compare
import yaml
import sys

def _check_schema(product_path: str, schema_path: str):
    product_configurations = ProductConfigurations(product_path)
    schema_configurations = ProductSchema(schema_path)

    compare = deep_compare(
        product_configurations.configuration_schema,
        schema_configurations.schema,
        "infra",
        "schema",
        )

    yaml.dump(compare, sys.stdout)


if __name__ == "__main__":
    app = typer.Typer()

    @app.command()
    def check_schema(product_path: str, schema_path: str):
        _check_schema(product_path, schema_path)

    app()

    #_check_schema('terraform\\products\\domain', 'terraform\\products\\domain\\configuration_schema.yaml')

    """NOTES:

    The system compares two ways at the moment.
    One issue is that in 'databricks_subnet.hcl' the key 'env_variables.virtual_network_data' is used, and somewhere else is 'env_variables.virtual_network_data.resource_group_name' used.
    The Databricks subnet Terraform module requires an input dictionary containing the keys 'resource_group_name' and 'name', but since the 'name' key is not referenced from Terragrunt, the schema can't include the 'name' key, since it would complain it can't find it in the configuration.
    """