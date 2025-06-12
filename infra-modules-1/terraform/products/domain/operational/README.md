

# Terraform Modules

This directory contains Terragrunt modules for deploying various components to a Databricks environment and Azure Data Factory (ADF) from the operational layer. Below is an explanation of each module and its purpose.

## Modules

### 1. `adf_deploy_component_payload`

This module is responsible for deploying component payloads to Azure Data Factory. It includes the following key functionalities:

- **Payload Directory Path**: Constructs the directory path for payloads based on the environment and an environment variable (`ARTIFACT_DIR_PATH`) where the artifactory resides.
- **Deployment Logic**: Ensures that the payloads are deployed to the correct directory within the Azure Data Factory environment.

### Databricks

#### 1. `deploy_custom_notebooks`

This module is used to deploy custom notebooks to a Databricks environment. It includes the following key functionalities:

- **Custom Notebook Deployment**: Handles the deployment of user-defined custom notebooks.
- **Dependency Management**: May depend on other modules to get necessary outputs like workspace URLs and credentials.

#### 2. `deploy_notebooks`

This module is used to deploy standard notebooks to a Databricks environment. It includes the following key functionalities:

- **Standard Notebook Deployment**: Handles the deployment of predefined standard notebooks.
- **Dependency Management**: May depend on other modules to get necessary outputs like workspace URLs and credentials.

#### 3. `deploy_package`

This module is used to deploy packages to a Databricks environment. It includes the following key functionalities:

- **Package Deployment**: Handles the deployment of various packages required for data processing and analytics.
- **Dependency Management**: May depend on other modules to get necessary outputs like workspace URLs and credentials.

#### 4. `deploy_package_to_specific_cluster`

This module is used to deploy a package to a specific Databricks cluster. It includes the following key functionalities:

- **Dependency Management**: It depends on the [`databricks_functional`] module to get necessary outputs like cluster IDs.
- **Inputs**: Accepts inputs such as files to be deployed and the specific cluster ID.
- **Conditional Execution**: Skips the module if the environment type is not [`dev`] or if no specific cluster is specified.

#### 5. `deploy_pipeline_notebooks`

This module is used to deploy pipeline notebooks to a Databricks environment. It includes the following key functionalities:

- **Notebook Deployment**: Handles the deployment of notebooks required for various data pipelines.

- **Dependency Management**: May depend on other modules to get necessary outputs like workspace URLs and credentials.

## Usage

This modules, can be executed as part of the whole Domain scope or from operational layer or individually.
Also executed from the deployment pipelines. 


## Environment Variables

To locally test, ensure that the following environment variables are set:

**ARTIFACT_DIR_PATH**: Base directory path for artifacts.
**TFSTATE_DATABRICKS_CLUSTER_NAME**: Name of the Databricks cluster for state management.

## Contributing

Feel free to open issues or submit pull requests if you find any bugs or have suggestions for improvements.



---

This README provides an overview of the modules and their functionalities, along with usage instructions and environment variable requirements.