"""Utility functions."""

from typing import Any, Dict, Iterable
from data_platform_env_config.configuration_model_base import ConfigurationModelBase


def unflat_dict(nested_dict_delimiter: str, flat_contents: Any) -> Dict:
    """Unflatten the dictionary based on the delimiter set in the class."""
    if not isinstance(flat_contents, dict):
        return flat_contents

    current_layer_keys = list(set([key if nested_dict_delimiter not in key else str(key).split(nested_dict_delimiter, maxsplit=1)[0] for key in flat_contents.keys()]))

    output = {}
    for current_key in current_layer_keys:
        sub_flat_dict = {str(k).split(nested_dict_delimiter, maxsplit=1)[1]: flat_contents[f"{current_key}{nested_dict_delimiter}{str(k).split(nested_dict_delimiter, maxsplit=1)[1]}"] for k in flat_contents if k.startswith(f"{current_key}{nested_dict_delimiter}")}
        if len(sub_flat_dict.keys()) == 0:
            output[current_key] = flat_contents[current_key]
        else:
            output[current_key] = unflat_dict(nested_dict_delimiter, sub_flat_dict)
    
    return output

def get_changes(configuration_old: ConfigurationModelBase, configuration_new: ConfigurationModelBase) -> Dict:
    """Determine the changes between the old and new configuration.

    Args:
        configuration_old (ConfigurationModelBase): Previous configuration.
        configuration_new (ConfigurationModelBase): New configuration to compare the previous to.

    Returns:
        Dict: Keys mapped to their changes.
    """
    dict_old = configuration_old.model_dump()
    dict_new = configuration_new.model_dump()

    output = dict_new.copy()
    for key, value in output.items():
        if value == dict_old[key]:
            output[key] += " -- UNCHANGED"
        else:
            output[key] += f" -- FROM {dict_old[key]}"
    return output