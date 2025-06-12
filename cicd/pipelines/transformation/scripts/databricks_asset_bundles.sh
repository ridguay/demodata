#!/bin/bash
# Revised script to deploy the Databricks asset bundle to the workspace.

parameters_action="deploy"  # TODO: add destroy option when adding clean up of unused asset bundles
parameters_environment=$1
parameters_target_user=$2
parameters_post_deploy_job=$3
bundle_dir="src/transformation"

echo "action: ${parameters_action}"
echo "parameters_environment: ${parameters_environment}"
echo "parameters_target_user: ${parameters_target_user}"
echo "parameters_post_deploy_job: ${parameters_post_deploy_job}"
echo "bundle_dir: ${bundle_dir}"

if [[ -z DATABRICKS_HOST ]]; then
    echo "DATABRICKS_HOST is not set!"
    exit 1
fi
if [[ -z DATABRICKS_TOKEN ]]; then
    echo "DATABRICKS_TOKEN is not set!"
    exit 1
fi

echo "##[command]cd ${bundle_dir}"
cd ${bundle_dir}

if [ -z $parameters_target_user ]; then
    env=$parameters_environment
else
    # If a target_user is set, inject that environment into the yaml file so we can use it as a target
    # Note the name prefix and root path using that user's CPA account in the environment
    # TODO: Do we want to prefix as $env on L42, or just hard-set this to 'dev' to indicate dev mode?
    user_environment=$(cat <<-END

  ${parameters_target_user}:
    workspace:
      host: ${DATABRICKS_HOST}
      root_path: /Shared/${parameters_target_user}/.bundle/\${bundle.name}
    presets:
      pipelines_development: true
      name_prefix: "[${parameters_environment} ${parameters_target_user}] "
      trigger_pause_status: PAUSED
      jobs_max_concurrent_runs: 10
      tags: 
        user: ${parameters_target_user}
END
)
    env=$parameters_target_user
    # Read in the bundle.yml contents, inject the new target and save the updated bundle
    bundle_yml=$(< bundle.yml)
    bundle_yml="${bundle_yml}${user_environment}"
    echo -e "$bundle_yml" > bundle.yml
fi

echo "##[command]databricks bundle validate --target ${env}"
databricks bundle validate --target ${env}
if [ $? -eq 1 ]; then
    # Bundle validation failed, unrecoverable
    exit 1
fi

# Deploy the bundle to the environment
echo "##[command]databricks bundle $parameters_action --target ${env}"
databricks bundle $parameters_action --target ${env}
if [ $? -eq 1 ]; then
    # Bundle deployment failed, unrecoverable
    exit 1
fi

# Optional: run a specific job in the bundle (e.g. tests) as a post-deploy action
if [ ! -z $parameters_post_deploy_job ]; then
    echo "##[command]databricks bundle run --target ${env} ${parameters_post_deploy_job}"
    databricks bundle run --target ${env} ${parameters_post_deploy_job}
    if [ $? -eq 1 ]; then
        # Post-deploy job failed, unrecoverable
        exit 1
    fi
fi
