"""Pydantic model of the environment configuration yaml files."""

import pydantic
from packaging import version

def validate_artifact_version(val: str) -> str:
    """Validate if the value is an accepted version format."""
    if not val[0] == 'v':
        raise Exception(f"Version {val} should start with 'v'.")
    
    if not version.parse(val[1:]):
        raise Exception(f"Version {val} not a valid version.")
    return val 

def validate_environment_version(val: str) -> str:
    """Validate if the value is an accepted version format."""
    if not len(val) == 2:
        raise Exception(f"Environment version {val} should have length 2.")
    
    try:
        # Try to convert the value to an integer to check if the version contains only numbers.
        int(val)
    except:
        raise Exception(f"Environment version {val} should be a valid integer.")

    return val 

class ConfigurationModelBase(pydantic.BaseModel):
    
    versions__infra_modules__artifact: str

    env_variables__TFSTATE_RESOURCE_GROUP_NAME: str
    env_variables__TFSTATE_STORAGE_ACCOUNT_NAME: str

    _validate_versions_infra_modules__artifact = pydantic.field_validator('versions__infra_modules__artifact')(validate_artifact_version)
