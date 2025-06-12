"""Class to interact with an environment file."""


import flatdict
from typing import Dict, Any
import os
import yaml
from data_platform_env_config.domain_configuration import DomainConfiguration
from data_platform_env_config.configuration_model_base import ConfigurationModelBase
from data_platform_env_config.utils import unflat_dict


class EnvsFile:
    NESTED_DICT_DELIMITER = "__"
    
    def __init__(self, file_path: str) -> None:
        self.file_path = file_path

        file_name = os.path.split(file_path)[-1]
        self.configuration_model = DomainConfiguration
    
    
    def read(self) -> ConfigurationModelBase:
        """Return the contents of the envs file as a dict.

        Returns:
            The contents of the environment file as a dictionary.
        """
        with open(self.file_path, "r", encoding="utf-8") as f:
            file_contents = yaml.safe_load(f)
        
        flat_contents = flatdict.FlatDict(file_contents, delimiter=self.NESTED_DICT_DELIMITER)
        return self.configuration_model(**flat_contents)
    
    def write(self, content: ConfigurationModelBase) -> None:
        """Write the specified content to the envs file.
        
        Args:
            content: Dictionary containing the content of the environments file.
        """
        flat_contents = content.model_dump()
        file_contents = unflat_dict(self.NESTED_DICT_DELIMITER, flat_contents)
        with open(self.file_path, mode="w", encoding="utf-8") as f:
            f.write(yaml.safe_dump(file_contents))
        
if __name__ == "__main__":
    e = EnvsFile("C:/Users/M66B232/PycharmProjects/data-platform/data-platform-env-config/envs_domain_split/dev.yaml")
    #e = EnvsFile("C:/Users/M66B232/PycharmProjects/data-platform/data-platform-env-config/envs_domain_split/adf-as-a-service-dev.yaml")