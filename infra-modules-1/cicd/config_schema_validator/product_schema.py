
import yaml

class ProductSchema:
    """Read and interpret the schema defined for a product."""

    def __init__(self, schema_path: str):
        self.schema_path = schema_path
        self.schema = self._read_schema(schema_path)
    
    def _read_schema(self, file_path: str):
        """Read the yaml file at the specified path and skip keys starting with underscores."""
        with open(file_path, "r", encoding="UTF-8", errors="ignore") as f:
            schema = yaml.safe_load(f)
        return self._purge_keys_with_underscores(schema)
            
    @classmethod
    def _purge_keys_with_underscores(cls, dictionary: dict):
        """Return the specified dictionary without the keys starting with underscores.
        If the value of a key only contains keys starting with underscores, the value will become an empty dictionary.
        """
        # First get the keys before looping through them, because the dictionary will be modified during the loop.
        keys_in_dict = list(dictionary.keys())
        output = {}
        for k in keys_in_dict:
            if k.startswith("_"):
                continue
            if isinstance(dictionary[k], dict):
                # Recursively traverse the dictionary to make sure all underscored keys are removed.
                output[k] = cls._purge_keys_with_underscores(dictionary[k])
            else:
                output[k] = dictionary[k]
        return output
    

if __name__ == "__main__":
    # For testing purposes
    product_schema = ProductSchema('C:\\Users\\M66B232\\programming\\lpdap\\platform\\infra-modules\\terraform\\products\\domain\\configuration_schema.yaml')
    print(product_schema.schema)