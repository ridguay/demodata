#!/bin/bash
parameters_environment=$1 # ${{ parameters.environment }}
parameters_environment_config_files_dir_path=$2 # ${{ parameters.environment_config_files_dir_path }}
parameters_trigger_ci=$3 # ${{ parameters.trigger_ci }} 
parameters_versions_argument=$4

echo "environment: ${parameters_environment}"
echo "versions arguments: ${parameters_versions_argument}"

echo "#############"
echo ""

# For each specified environment, update the yaml file
for env in $parameters_environment; do
    echo "env: $env"
    echo "config file: ${parameters_environment_config_files_dir_path}/${env}.yaml"

    poetry run python ${SYSTEM_DEFAULTWORKINGDIRECTORY}/src/data_platform_env_config/main.py update-value "$parameters_environment_config_files_dir_path/${env}.yaml" $parameters_versions_argument
    echo "#############"
    echo ""
done

# check if there are difference in the commit.
git diff --exit-code
docommit=$?
echo "##[debug]docommit=$docommit"

if [ ${docommit} == "1" ]; then
                
    echo "Commit the updated files"
                
    # ${SYSTEM_TEAMPROJECT} is the name of the project, for example: "LPDAP_Data Customer Workflow"
    # Cut off the first 11 characters to end up with "Customer Workflow"
    project_name=${SYSTEM_TEAMPROJECT:6}
    # Replace all spaces with underscores
    project_name="${project_name// /_}"

    git config --global user.email "${project_name}-bot@lpdap.nl"
    git config --global user.name "${project_name} Bot"

    commit_message="${parameters_environment}: ${parameters_versions_argument}"
    if [ ${parameters_trigger_ci} == "no" ]; then
        commit_message="$commit_message [skip ci]"
    fi
    git commit -a -m "$commit_message"

    echo "##[command]git commit -a -m Pipeline commit"
    git commit -a -m "Pipeline commit"

    # Added git pull to hopefully fix the issue with failing pipelines, because they were started close to each other.
    echo "##[command]git pull https://${SYSTEM_ACCESSTOKEN}@dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/data-platform-env-config HEAD:${BUILD_SOURCEBRANCHNAME}"
    git pull https://${SYSTEM_ACCESSTOKEN}@dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/data-platform-env-config HEAD:${BUILD_SOURCEBRANCHNAME}

    echo "##[command]git push https://${SYSTEM_ACCESSTOKEN}@dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/data-platform-env-config HEAD:${BUILD_SOURCEBRANCHNAME}"
    git push https://${SYSTEM_ACCESSTOKEN}@dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/data-platform-env-config HEAD:${BUILD_SOURCEBRANCHNAME}
else
    echo "Nothing to commit"
fi

exit 0