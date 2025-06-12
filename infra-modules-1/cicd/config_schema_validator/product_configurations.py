
from terragrunt_file import get_terragrunt_file_configurations
from pathlib import Path
from dict_utils import deep_merge

class ProductConfigurations:
    """Analyse a product and store all configurations present in the product."""

    def __init__(self, product_path: str):
        files_in_product = Path(product_path).rglob("**/terragrunt.hcl")

        # Parse all terragrunt files in this product and store their matching TerragruntFile object in this dictionary.
        self.terragrunt_file_configurations = {}
        for file_path in files_in_product:
            self.terragrunt_file_configurations[file_path] = get_terragrunt_file_configurations(str(file_path.absolute()))

        # Get the configurations of all files and convert them to a dictionary ready for comparison.
        self.configurations = self._get_configurations()
        self.configuration_schema = self._get_configuration_schema(self.configurations)

    def _get_configurations(self):
        """Return all configurations present in the whole product.
        The output is a dictionary with the keys being the configuration and the values being the paths to the terragrunt files where the configuration is used.
        """
        configurations = {}
        for path, terragrunt_file in self.terragrunt_file_configurations.items():
            # The terragrunt_file objects each contain a list of configurations, which all should be collected.
            # The configurations here still have the format `infrastructure_configuration.<..>.<..>`.
            for configuration in terragrunt_file:
                if configuration not in configurations:
                    configurations[configuration] = []
                configurations[configuration].append(path)
        
        return configurations
    
    def _get_configuration_schema(self, configurations: dict):
        """Return the schema of the implemented configurations."""
        schema = {}
        for key in configurations:
            # Each key is build up like: domain_variables.ip_addresses.data_factory_private_endpoint
            # So, split on '.', to infer the different levels
            split = key.split(".")
            # Variable used to build up the dictionary structure of one configuration.
            # For example: 'domain_variables.ip_addresses.data_factory_private_endpoint' will be converted to:
            # {
            #    'domain_variables': {
            #       'ip_addresses': {
            #           'data_factory_private_endpoint': {}
            #       }
            #   }
            #}
            helper = {}
            for i in range(len(split)):
                helper = {
                    split[len(split) - i - 1]: helper
                }
            # The helper variable contains the schema of one configuration, merge this with the total schema.
            schema = deep_merge(schema, helper)
        return schema


if __name__ == "__main__":
    # For testing purposes
    product_configuration = ProductConfigurations('C:\\Users\\M66B232\\programming\\lpdap\\platform\\infra-modules\\terraform\\products\\domain')
    for k, v in product_configuration.configurations.items():
        print(f"{k}: {v}")

    print(product_configuration.configuration_schema)