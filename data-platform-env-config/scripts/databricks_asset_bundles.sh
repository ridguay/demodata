#!/bin/bash
# Script to deploy the Databricks asset bundle to the workspace.

# Directory to store the logic artifact in. If it exists it will be removed first to clean up previous runs.
parameters_project_name=$1
parameters_action=$2
parameters_environment=$3
parameters_workspace_host=$4
parameters_workspace_pat=$5
parameters_databricks_bundle_root_dir=$6
parameters_dry_run=$7

echo "## Parameters: #"
echo "# project name: ${parameters_project_name}"
echo "# action: ${parameters_action}"
echo "# environment: ${parameters_environment}"
echo "# workspace host: ${parameters_workspace_host}"
echo "# workspace PAT: ${parameters_workspace_pat}"
echo "# databricks_bundle_root_dir: ${parameters_databricks_bundle_root_dir}"
echo "# dry run: ${parameters_dry_run}"
echo "################"

# Remove the bundle if it already exists
if [ -f bundle.yml ]; then
    rm bundle.yml
fi

echo "##[command]echo \"${parameters_workspace_pat}\" | databricks configure --host \"${parameters_workspace_host}\""
echo "${parameters_workspace_pat}" | databricks configure --host "${parameters_workspace_host}"

# Unable to configure Databricks CLI, unrecoverable.
if [ $? -eq 1 ]; then
    exit 1
fi

# Auto approve destroys whenever we are in sbx, pdv, or dev and use --force-lock
# Check which bundle template to use based on the Databricks CLI version
if [[ "Databricks CLI v0.215.0" == "$(databricks -v)" ]]; then
    folder="./databricks_asset_bundles_template"
    extra_flags=""
else
    folder="./databricks_asset_bundles_template_v2"
    extra_flags="--auto-approve"
    if [[ " sbx pdv dev " =~ " ${parameters_environment} " ]]; then
        extra_flags="${extra_flags} --force-lock"
    fi
fi

# Check if the config file contains the databricks_bundle_root_dir
check_string="databricks_bundle_root_dir"
schema_file="${folder}/databricks_template_schema.json"

config_file_content="{\"project_name\":\"${parameters_project_name}\",\"workspace_host\":\"${parameters_workspace_host}\""

# Create base contents of the config file (without closing curly bracket).
if grep -q "$check_string" "$schema_file"; then
    # The bundle requires the input parameter "databricks_bundle_root_dir", so add it.
     echo "Input parameter 'databricks_bundle_root_dir' found in schema."
     config_file_content="${config_file_content},\"databricks_bundle_root_dir\":\"${parameters_databricks_bundle_root_dir}\""
fi

# Close the config file json content with a curly bracket, and put the content back in config_file.json
config_file_content="${config_file_content}}"
echo "##[command]echo \"$config_file_content\" > config_file.json"
echo "$config_file_content" > config_file.json

echo "##[command]databricks bundle init \"${folder}\" --config-file=config_file.json"
databricks bundle init "${folder}" --config-file=config_file.json

# Bundle init returned an error, unrecoverable.
if [ $? -eq 1 ]; then
    exit 1
fi

echo "##[command]rm config_file.json"
rm config_file.json

echo "##[command]databricks bundle validate --target ${parameters_environment}"
databricks bundle validate --target ${parameters_environment}

# Bundle validation failed, unrecoverable.
if [ $? -eq 1 ]; then
    exit 1
fi

# Copy the bundle file to the src/ingestion/sources directory so it gets uploaded to the workspace for debugging purposes
echo "##[command]cp bundle.yml src/ingestion/sources/"
cp bundle.yml src/ingestion/sources/

# Deploy the bundle to the environment
databricks_bundle_action="deploy"
if [[ $parameters_action == "destroy" ]]; then
    databricks_bundle_action="destroy"
fi

echo "##[command]databricks bundle $databricks_bundle_action --target ${parameters_environment} ${extra_flags}"
if [[ ${parameters_dry_run} != "True" ]]; then
    echo "No dry run: Do run command"
    databricks bundle $databricks_bundle_action --target ${parameters_environment} ${extra_flags}
    
    # Bundle deploy/destroy failed, unrecoverable.
    if [ $? -eq 1 ]; then
        exit 1
    fi
else
    echo "Dry run: Don't run command"
fi

exit 0
