
from typing import Any, Union

def _deep_merge_dictionary_values(val_1: Any, val_2: Any, key: str) -> Any:
    """Merge val_1 and val_2 together and return the merged result.

    Args:
        val_1 (Any): Value for the key in the first dictionary.
        val_2 (Any): Value for the key in the second dictionary.
        key (str): Key the values are associated with.

    Raises:
        Exception: When the types of the values don't match.
    """
    # If the type of the value doesn't match, we have undefined behavior, so raise an error.
    if type(val_1) != type(val_2):
        raise Exception(f"{key}: Key contains different types of values in both dictionaries.")
    
    # If the value is not a dictionary, just use the value of dict_2.
    if not isinstance(val_2, dict):
        return val_2

    # Both values are dictionaries, so merge them recursively.
    return deep_merge(val_1, val_2)


def deep_merge(dict_1: dict, dict_2: dict) -> dict:
    """Merge the two dictionaries into one.
    Keys present in either dictionary will be present in the output dictionary.
    Keys containing other dictionaries will be merged recursively.
    Keys containing different values will be overwritten by the value in dict_2.
    If keys contain different types of values the merge will raise an error.
    """
    dict_1_keys = list(dict_1.keys())
    dict_2_keys = list(dict_2.keys())
    keys_in_1_not_in_2 = list(set(dict_1_keys) - set(dict_2_keys))
    keys_in_2_not_in_1 = list(set(dict_2_keys) - set(dict_1_keys))
    keys_in_both = list(set(dict_1_keys) & set(dict_2_keys))

    # Add the keys that are only present in one of the dictionaries.
    output = {
        **{k: v for k, v in dict_1.items() if k in keys_in_1_not_in_2},
        **{k: v for k, v in dict_2.items() if k in keys_in_2_not_in_1},
    }
    
    for key in keys_in_both:
        output[key] = _deep_merge_dictionary_values(dict_1[key], dict_2[key], key)
    return output



def _deep_compare_dictionary_values(val_1: Any, val_2: Any, key: str, dict_1_name: str, dict_2_name: str) -> Union[None, dict, str]:
    # To be sure, but this should not happen, because keys with different types are filtered out in the 'deep_merge' step.
    if type(val_1) != type(val_2):
        return f"{dict_1_name} type: {type(val_1)}, {dict_2_name} type: {type(val_2)}."
    
    # Compare the values if they are not dictionaries.
    if not isinstance(val_2, dict):
        if not val_1 == val_2:
            return f"{dict_1_name}: {val_1}, {dict_2_name}: {val_2}."
        return None
        
    # Both values are dictionaries, so compare them recursively
    recursive_output = deep_compare(val_1, val_2, dict_1_name, dict_2_name)
    if not recursive_output == {}:
        return recursive_output


def deep_compare(dict_1: dict, dict_2: dict, dict_1_name: str = "source", dict_2_name: str = "target"):
    """Compare the two dictionaries and return the differences in a dictionary."""
    dict_1_keys = list(dict_1.keys())
    dict_2_keys = list(dict_2.keys())
    keys_in_1_not_in_2 = list(set(dict_1_keys) - set(dict_2_keys))
    keys_in_2_not_in_1 = list(set(dict_2_keys) - set(dict_1_keys))
    keys_in_both = list(set(dict_1_keys) & set(dict_2_keys))

    # Mark the keys that are only present in one of the dictionaries to be missing in the other.
    output = {
        **{k: f"Missing in {dict_2_name}." for k in keys_in_1_not_in_2},
        **{k: f"Missing in {dict_1_name}." for k in keys_in_2_not_in_1},
    }

    for key in keys_in_both:
        dict_value = _deep_compare_dictionary_values(dict_1[key], dict_2[key], key, dict_1_name, dict_2_name)
        if not dict_value is None:
            output[key] = dict_value # type: ignore
    return output


if __name__ == "__main__":
    # For testing purposes
    def test_deep_merge():
        testcases = [
            {
                '1': {'a': 1, 'b': 2},
                '2': {'a': 2, 'b': 3},
                'expected': {'a': 2, 'b': 3},
            },
            {
                '1': {'a': {'b': {'c': 1}}},
                '2': {'a': {'b': {'d': 2}}},
                'expected': {'a': {'b': {'c': 1, 'd': 2}}},
            },
            {
                '1': {'a': {'e': {'f': 1}}},
                '2': {'a': {'b': {'d': 2}}},
                'expected': {'a': {'b': {'d': 2}, 'e': {'f': 1}}},
            },
        ]

        for case in testcases:
            merged = deep_merge(case['1'], case['2'])
            assert merged == case['expected'], f"Expected {case['expected']} but got {merged}"
            
    #test_deep_merge() 

    def test_deep_compare():
        testcases = [
            {
                '1': {'a': 1, 'b': 2},
                '2': {'a': 1, 'b': 3},
                'expected': {'b': 'Source: 2, target: 3.'},
            },
            {
                '1': {'a': {'b': {'c': 1}}},
                '2': {'a': {'b': {'d': 2}}},
                'expected': {'a': {'b': {'c': 'Missing in target.', 'd': 'Missing in source.'}}},
            },
            {
                '1': {'a': {'b': {'d': 1, 'e': 2}, 'c': 1}},
                '2': {'a': {'c': 1}},
                'expected': {'a': {'b': 'Missing in target.'}},
            },
        ]

        for case in testcases:
            compared = deep_compare(case['1'], case['2'])
            assert compared == case['expected'], f"Expected {case['expected']} but got {compared}"
            
    #test_deep_compare() 
