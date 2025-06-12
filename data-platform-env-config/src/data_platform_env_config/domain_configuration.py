"""Pydantic model of the environment configuration yaml files for the domain environments."""

import pydantic
from data_platform_env_config.configuration_model_base import ConfigurationModelBase, validate_artifact_version, validate_environment_version


class DomainConfiguration(ConfigurationModelBase):
    
    versions__customer_workflow__artifact: str
    versions__customer_workflow__environment_version: str

    versions__pensions__artifact: str
    versions__pensions__environment_version: str

    versions__individual__artifact: str
    versions__individual__environment_version: str

    _validate_versions_artifact = pydantic.field_validator('versions__customer_workflow__artifact', 'versions__pensions__artifact', 'versions__individual__artifact')(validate_artifact_version)
    _validate_environment_version = pydantic.field_validator('versions__customer_workflow__environment_version', 'versions__pensions__environment_version', 'versions__individual__environment_version')(validate_environment_version)
