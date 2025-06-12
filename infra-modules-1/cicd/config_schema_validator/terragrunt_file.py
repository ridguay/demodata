
import re
import os

# These variables regular expressions used to find the input configuration and find what Terragrunt modules are included in the target file, so they can also be parsed.
# They are defined on top, to make it easier to change them if needed.

# This matches the include block: `include "..." { ... }`
RE_MATCH_IMPORT_STATEMENTS = r'include ".*" {[\S\s]*?(?=\n})\n}'
# Inside each include block, there is a path specified, this isolates that line. It also excludes paths that are not wrapped in quotes, which is the case for 'path = find_in_parent_folders()'.
# It is split up, because after the whole line is found, the path itself has to be isolated (which is done by only the second pattern).
RE_MATCH_PATH_IN_INCLUDE_BLOCK = (r'path *', r'= *".*"\n')

# When the 'TERRAGRUNT_TERRAFORM_DIR' is used, it should be replaced with the actual value of that environment variable. This isolates the call to that environment variable.
RE_MATCH_TERRAGRUNT_TERRAFORM_DIR = r'\${get_env\("TERRAGRUNT_TERRAFORM_DIR".*\)}'

# The configurations have the following format:
# - local.root.locals.env_variables.<..>
# - local.root.locals.domain_variables.<..>
# - local.root.locals.infrastructure_configuration.<..>
# - include.root.locals.env_variables.<..>
# - include.root.locals.domain_variables.<..>
# - include.root.locals.infrastructure_configuration.<..>
# This matches that, it is split in two because the first part has to be trimmed before it is outputted.
# Note: the [a-zA-Z0-9_.]* matches only alphanumeric characters, underscores and dots, which are the characters allowed in Terragrunt variables.
RE_MATCH_CONFIGURATIONS = (r'(local|include).root.locals.', r'(infrastructure_configuration|env_variables|domain_variables).[a-zA-Z0-9_.]*')


def _get_terragrunt_terraform_dir_var() -> str:
    """Return the Terragrunt Terraform directory variable."""
    return str(os.environ.get("TERRAGRUNT_TERRAFORM_DIR"))


def _read(path: str) -> str:
    """Read the Terragrunt file."""
    with open(path, "r", encoding="UTF-8", errors="ignore") as f:
        return f.read()


def _get_configurations_from_hcl(text: str):
    """Return configurations used in the specified text based on the specified regular expression patterns in the class.
    The output is a list of configurations in the following format: `infrastructure_configuration.<..>.<..>`.
    """
    # Match all configurations in the text
    re_match_configuration = re.compile(RE_MATCH_CONFIGURATIONS[0] + RE_MATCH_CONFIGURATIONS[1])
    configurations = re_match_configuration.finditer(text)

    output = []
    for configuration in configurations:
        # For each configuration found, trim the leading part that looks like for example `local.root.locals`, since that has no value for our schema.
        output.append(re.split(RE_MATCH_CONFIGURATIONS[0], configuration.group())[-1])
    return output

def _get_imports(text: str, terragrunt_file_path: str):
    """Return collection of paths to all imported Terragrunt modules from this module."""
    # Isolate all import blocks in the text
    re_import_statements = re.compile(RE_MATCH_IMPORT_STATEMENTS)
    import_blocks = re_import_statements.findall(text)

    re_path_in_include_block = re.compile(RE_MATCH_PATH_IN_INCLUDE_BLOCK[0] + RE_MATCH_PATH_IN_INCLUDE_BLOCK[1])
    re_string_in_block = re.compile(RE_MATCH_PATH_IN_INCLUDE_BLOCK[1])
    #re_string_in_block = re.compile(r'*= *".*"\n')
#RE_MATCH_PATH_IN_INCLUDE_BLOCK = (r'path ', r'*= *".*"\n')
    imports = []
    for import_block in import_blocks:
        # Isolate the line containing the path
        path = re_path_in_include_block.search(import_block)

        # If the path isn't wrapped in quotes, it is disregarded, so then this is True.
        if path is None:
            continue

        # Isolate the value of the path key, this still contains some extra leading and trailing characters, which have to be removed.
        path_line = re_string_in_block.search(path.group())
        if path_line is None:
            raise Exception(f"Include block in file {terragrunt_file_path} does not contain path line. This should not happen, since the path line is matched in the step before this.")

        # Remove the leading and trailing characters from the path string so the actual value remains.
        path_string = re.split(r'= *"', path_line.group())[-1]
        path_string = path_string.rstrip('"\n')

        # If the path contains the 'TERRAGRUNT_TERRAFORM_DIR' environment variable, it should be replaced with the actual value of that environment variable.
        terragrunt_terraform_dir_in_path = re.split(RE_MATCH_TERRAGRUNT_TERRAFORM_DIR, path_string)
        absolute_path_string = "".join([e if not e == '' else _get_terragrunt_terraform_dir_var() for e in terragrunt_terraform_dir_in_path])

        imports.append(absolute_path_string)
    return imports

def get_terragrunt_file_configurations(file_path: str) -> list:
    """Return all configurations present in the specified Terragrunt file."""
    if "TERRAGRUNT_TERRAFORM_DIR" not in os.environ:
        raise Exception("Environment variable TERRAGRUNT_TERRAFORM_DIR not set.")
    
    text = _read(file_path)

    # Get the configurations that are specified in this file.
    configurations = _get_configurations_from_hcl(text)

    # Gather all Terragrunt files that are imported in this file and also parse them for configurations.
    # Terragrunt doesn't support nested imports, so these files don't have to be parsed recursively.
    imports = _get_imports(text, file_path)
    for import_path in imports:
        text = _read(import_path)
        configurations.extend(_get_configurations_from_hcl(text))
    
    configurations = list(set(configurations))

    return configurations


if __name__ == "__main__":
    # For testing purposes
    #f = TerragruntFile("C:/Users/M66B232/programming/lpdap/platform/infra-modules/terraform/products/domain/~1/databricks_subnet/terragrunt.hcl")
    f = get_terragrunt_file_configurations("C:/Users/M66B232/programming/lpdap/platform/infra-modules/terraform/products/domain/~1/~2/storage/storage_account/terragrunt.hcl")
    
    print(f)