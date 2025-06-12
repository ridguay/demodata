"""Main entrypoint of the cli."""

from data_platform_env_config.envs_file import EnvsFile
from data_platform_env_config.utils import get_changes
from typing import Any, Dict, List

def _update_value(path_to_envs_file: str, new_values: Dict, dry_run: bool) -> None:
    """Update the value under the specified path.

    Args:
        path_to_envs_file (str): Path to the file containing the environment configuration.
        new_values (Dict): Values to update the configuration with, nested keys separated by '__'.
        dry_run: When True, only display the changes without changing anything.
    """
    envs_file = EnvsFile(path_to_envs_file)
    configuration = envs_file.read()
    configuration_new = configuration.model_copy(update=new_values)

    if not dry_run:
        envs_file.write(configuration_new)

    changes = get_changes(configuration, configuration_new)

    for change in changes:
        print(f"{change} : {changes[change]}")
    
def _value_is_different(path_to_envs_file_one: str, path_to_envs_file_two: str, key: str) -> str:
        """Compares the value of the specified key for the two envs files and return if it is changed or not.

        Args:
            path_to_envs_file_one (str): Path to the first configuration yaml file holding versions.
            path_to_envs_file_two (str): Path to the first configuration yaml file holding versions.
            key (str): Key to the value that has to be checked for changes, nested keys separated by '__',
                in the format ['versions__customer_workflow__artifact:v1.2.3'].
        
        Returns:
            Whether or not the value is changed.
        """
        envs_file_one = EnvsFile(path_to_envs_file_one)
        envs_file_two = EnvsFile(path_to_envs_file_two)

        configuration_one = envs_file_one.read()
        configuration_two = envs_file_two.read()

        try:
            attribute_one = configuration_one.__getattribute__(key)
            attribute_two = configuration_two.__getattribute__(key)
            if attribute_one == attribute_two:
                return "False"
        except:
            return "ERROR"
        return "True"

    
if __name__ == "__main__":
    import typer
    
    app = typer.Typer()

    @app.command()
    def update_value(path_to_envs_file: str, new_values: List[str], dry_run: bool = False):
        """Update the versions in the specified file_path.

        Args:
            path_to_envs_file: Path to the configuration yaml file holding the versions.
            new_values: List containing the keys mapped to the new required values,
                nested keys separated by '__', in the format ['versions__customer_workflow__artifact:v1.2.3'].
            dry_run: When True, only display the changes without changing anything.

        Raises:
            Exception: When the specified format ['versions__customer_workflow__artifact:v1.2.3'] is not met.
        """
        input_new_values = {}
        for element in new_values:
            # Split the element on the ':' character
            key_value = element.split(":")
            if not len(key_value) == 2:
                raise Exception(f"Couldn't parse version {element}.")
            # Save the element in the input_new_versions with as key the microservice name and als value the version
            input_new_values[key_value[0]] = key_value[1]
        _update_value(path_to_envs_file, input_new_values, dry_run)

    @app.command()
    def value_is_different(path_to_envs_file_one: str, path_to_envs_file_two: str, key: str) -> None:
        """Compares the value of the specified key for the two envs files and return if it is changed or not.

        Args:
            path_to_envs_file_one (str): Path to the first configuration yaml file holding versions.
            path_to_envs_file_two (str): Path to the first configuration yaml file holding versions.
            key (str): Key to the value that has to be checked for changes, nested keys separated by '__',
                in the format ['versions__customer_workflow__artifact:v1.2.3'].
        """
        print(_value_is_different(path_to_envs_file_one, path_to_envs_file_two, key))


    app()