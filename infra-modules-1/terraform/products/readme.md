# How To deploy a product


## Create environment variables

Create three new environment variables.

`PLATFORM_CONFIGURATION_FILE`, this should point to the configuration file for the domain "platform" i.g.,`\terraform\configuration\platform\platform.yaml`,
`$env:PLATFORM_CONFIGURATION_FILE="C:\Users\m64g438\git\byte-club\infra-modules\terraform\configuration\platform\platform.yaml"`

For the domain level the correspond variable is:
`PRODUCT_CONFIGURATION_FILE`, this should point to the configuration file of your domain product, i.g.,`$env:PRODUCT_CONFIGURATION_FILE="C:\Users\m64g438\git\byte-club\infra-modules\terraform\configuration\products\menno.yaml"`

Each environment has an unique file, that is referenced with the following variable, i.g.,`$env:ENV_CONFIGURATION_FILE="C:\Users\m64g438\git\byte-club\infra-modules\terraform\configuration\envs\sbx.yaml"`
`ENV_CONFIGURATION_FILE`

## Add values to meta keyvaults

Also two value's need to be created in the meta keyvaults.

    mno-databricks-git-sync-devops-username
    mno-databricks-git-sync-devops-pat

## Deploy

To deploy the environment go to the folder terraform\products\domain and deploy

`terragrunt run-all apply --terragrunt-ignore-external-dependencies`

## Select variables tool

To make easier to work with multiple variables a powershell script has been created, to select for environment and domain.
`utils/select_env_domain_variables_files.ps1`
