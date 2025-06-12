"""Test the utils class."""

from typing import Dict
from data_platform_env_config.utils import unflat_dict, get_changes
from data_platform_env_config.domain_configuration import DomainConfiguration
import flatdict
import pytest


class TestUtils:
    
    @pytest.mark.parametrize('nested_dict', [
        {
                        "1": {
                "11": {
                    "111": "v111",
                    "112": "v112",
                },
                "12": "v12",
            },
            "2": {
                "21": {
                    "211": "v211",
                    "212": "v212",
                },
                "22": "v22",
            },

        },
        {
            'a': 'b',
            'c': {
                'd': 'e',
            },
            'f': {
                'g': {
                    'h': 'i'
                }
            }
        },
        {},
        {
            'a': 'b'
        },
        {
            'a': {
                'b': 'c',
            },
            'd': {
                'b': 'e',
            },
        },
    ])
    def test_unflat_dict(self, nested_dict: Dict) -> None:
        """Test if the unflat_dict method is the inverse of the flatdict method."""
        flat = flatdict.FlatDict(nested_dict, "__")

        assert nested_dict == unflat_dict("__", flat)

    def test_get_changes(self) -> None:
        """Test the get_changes method."""
        configuration_old = DomainConfiguration(
            versions__infra_modules__artifact="v1.2.3",

            versions__customer_workflow__artifact="v1.2.3",
            versions__customer_workflow__environment_version="01",

            versions__individual__artifact="v1.2.3",
            versions__individual__environment_version="21",

            versions__pensions__artifact="v1.2.3",
            versions__pensions__environment_version="43",

            versions__mall_main__artifact="v1.2.3",
            versions__mall_main__environment_version="44",

            env_variables__TFSTATE_RESOURCE_GROUP_NAME="test_name1",
            env_variables__TFSTATE_STORAGE_ACCOUNT_NAME="test_name2",
        )
        configuration_new = configuration_old.model_copy(update={
            "versions__customer_workflow__artifact": "v2.3.4",
            "versions__infra_modules__artifact": "v2.3.4",
        })

        expected = {
            "versions__infra_modules__artifact": "v2.3.4 -- FROM v1.2.3",

            "versions__customer_workflow__artifact": "v2.3.4 -- FROM v1.2.3",
            "versions__customer_workflow__environment_version": "01 -- UNCHANGED",

            "versions__individual__artifact": "v1.2.3 -- UNCHANGED",
            "versions__individual__environment_version": "21 -- UNCHANGED",

            "versions__pensions__artifact": "v1.2.3 -- UNCHANGED",
            "versions__pensions__environment_version": "43 -- UNCHANGED",

            "versions__mall_main__artifact": "v1.2.3 -- UNCHANGED",
            "versions__mall_main__environment_version": "44 -- UNCHANGED",

            "env_variables__TFSTATE_RESOURCE_GROUP_NAME": "test_name1 -- UNCHANGED",
            "env_variables__TFSTATE_STORAGE_ACCOUNT_NAME": "test_name2 -- UNCHANGED",
        }

        actual = get_changes(configuration_old, configuration_new)

        assert actual == expected