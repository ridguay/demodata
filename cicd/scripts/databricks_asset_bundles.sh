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

echo "project name: ${parameters_project_name}"
echo "action: ${parameters_action}"
echo "environment: ${parameters_environment}"
echo "workspace host: ${parameters_workspace_host}"
echo "workspace pat: ${parameters_workspace_pat}"
echo "databricks_bundle_root_dir: ${parameters_databricks_bundle_root_dir}"
echo "dry run: ${parameters_dry_run}"

echo "#############"
echo ""

echo "##[command]echo \"${parameters_workspace_pat}\" | databricks configure --host \"${parameters_workspace_host}\""
echo "${parameters_workspace_pat}" | databricks configure --host "${parameters_workspace_host}"

if [ $? -eq 1 ]; then
    # The output code of the previous command is 1, which means an error is raised.
    exit 1
fi
#Check if the config file contains the databricks_bundle_root_dir
check_string="databricks_bundle_root_dir"
schema_file="./databricks_asset_bundles_template/databricks_template_schema.json"


# Create base contents of the config file (without closing curly bracket).
config_file_content="{\"project_name\":\"${parameters_project_name}\",\"workspace_host\":\"${parameters_workspace_host}\""

if grep -q "$check_string" "$schema_file"; then
    # The bundle requires the input parameter "databricks_bundle_root_dir", so add it.
     echo "Input parameter 'databricks_bundle_root_dir' found in schema."
     config_file_content="${config_file_content},\"databricks_bundle_root_dir\":\"${parameters_databricks_bundle_root_dir}\""
fi

# Close the config file json content with a curly bracket.
config_file_content="${config_file_content}}"
echo "##[command]echo \"$config_file_content\" > config_file.json"
echo "$config_file_content" > config_file.json



echo "##[command]databricks bundle init \"./databricks_asset_bundles_template\" --config-file=config_file.json"
databricks bundle init "./databricks_asset_bundles_template" --config-file=config_file.json

if [ $? -eq 1 ]; then
    # The output code of the previous command is 1, which means an error is raised.
    exit 1
fi

echo "##[command]rm config_file.json"
rm config_file.json

echo "##[command]databricks bundle validate --target ${parameters_environment}"
databricks bundle validate --target ${parameters_environment}

if [ $? -eq 1 ]; then
    # The output code of the previous command is 1, which means an error is raised.
    exit 1
fi

# Deploy the bundle to the environment
databricks_bundle_action="deploy"
if [[ $parameters_action == "destroy" ]]; then
    databricks_bundle_action="destroy"
fi

echo "##[command]databricks bundle $databricks_bundle_action --target ${parameters_environment}"
if [[ ${parameters_dry_run} != "True" ]]; then
    echo "No dry run: Do run command"
    databricks bundle $databricks_bundle_action --target ${parameters_environment}
else
    echo "Dry run: Don\'t run command"
fi