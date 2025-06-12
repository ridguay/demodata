# Infra modules
This repository contains the configuration for the infrastructure for the Life & Pensions Data Analytics Platform.

# Technology Stack

- [terraform](https://www.terraform.io/)
  - [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
  - [databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs)
  - [azapi](https://registry.terraform.io/providers/Azure/azapi/latest/docs)
  - [terraform-docs](https://terraform-docs.io/)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [semantic-release](https://semantic-release.gitbook.io/semantic-release/)
- [conventional-commits](https://www.conventionalcommits.org/en/v1.0.0/)

# Inner workings of the repository

Terraform is an industry standard language to define your infrastructure as code (IaC) for the managing and provisioning of 
infrastructure through code instead of through manual processes. Unfortunately, Terraform (at the time of writing) comes
with a drawback that it contains the characteristic that it requires a significant amount of duplicate code.

To overcome this drawback and adhere to the software engineering DRY principle (_"Don't Repeat 
Yourself"_) Terragrunt (a small wrapper around Terraform) is used that allows the definition of blocks like providers once, 
and inherit this multiple times. 

By making use of both technologies the `/terraform/environments` directory contains the environment specific Terragrunt 
configuration which makes use of Terraform modules specified in the `/terraform/modules/` directory.

## Default environment configuration

To DRY up the codebase even more, a **_default_** environment (platform) configuration is defined within the 
`environments/_env` folder. This default platform configuration is used (and acts as a blueprint) for the (real)
environments: `dev`, `tst`, `acc` and `prd`, (extra specific environment configuration can still be specified within
these environments).

**For example:**  

- The file `/terraform/environments/_env/databricks/deploy_package.hcl` contains the configuration to deploy 
the data-source-logic python package to the dbfs and install it on the Databricks cluster.
- This file is referenced by `/terraform/environments/dev/~1/~2/~3/~4/~5/~6/~7/databricks/deploy_package/terragrunt.hcl`, 
but you can see that this file adds some extra logic in the form of a `skip`. 
_A skip means that the logic (to deploy the package to dbfs) is not (always) executed._  
- The same file is referenced by `/terraform/environments/tst/~1/~2/~3/~4/~5/~6/~7/databricks/deploy_package/terragrunt.hcl`, 
_(notice the environment)_ for this environment there is no extra configuration required.

## Terraform modules

The Terraform modules live in the `/terraform/modules` directory. They are split into three categories: `core`, 
`extensions` and `networking`: 

- The `networking` and `core` were originally the modules copied from the NNDAP infrastructure.
This is no longer the case, but the directory is not yet refactored.

- The `extensions` category holds the modules that provide features specifically required within the LPDAP. These 
modules are completely custom and implemented by the developement team of LP.

## Terragrunt environment configuration

A Terragrunt environment configuration, for example the `/terraform/environments/tst`, at its highest level consists of the following parts:

- The `terragrunt.hcl`: Contains configuration that is needed for all Terragrunt configuration `.hcl` files within the 
  environment. In here the main Terraform azurerm provider is defined, further a `locals` block is defined which contains the global variables that are used within the (other) Terragrunt files.
- A `variables.yaml` file in the root: This file contains environment specific values.
  These values are used throughout the configuration e.g. providing roles to data engineers.  
- The `platform` directory: this contains the subscription wide infrastructure, for example some networking.
  This part is the foundation of the other platforms and should be deployed before the Data Domains are deployed.
- The four Data Domain directories (`customer_workflow`, `finance`, `individual`, `pensions`): These are the configurations for the actual platforms.
  Each contain a multi level structure that defines the data platform.

> **Note**
> Before the platform was split into the four Data Domains, there was one centralized platform.
> This configuration has to be maintained for a while as well (next to the new domains).
> Therefore there are also some artifacts from the previous platform configuration visible in this repository.

### Platform Multi Level Structure

For each Data Domain, there is a multi leveled platform specified.
The platform has 7 layers (but there could be more), and each level has the following properties:

- Each level represents a 'layer of importance', with level 1 being the most important.
  In this case, more 'important' means that the resource should be less easily destroyed and redeployed.
- Terragrunt modules can never depend on other Terragrunt modules from level higher than itself.
  For example: A module in level 3 can only depend on other modules in level 3, 2 or 1.

This split in levels enables an easy way to destroy (and redeloy) for example only level 6 and 7 (which are very quickly to deploy), while ensuring the safety of the data, which is stored in level 2.

A short explanation for each level:

- **level 1**: The base level. This contains things like networking and the resource group for other resources. This should only be destroyed when the whole platform is redeployed.
- **level 2**: Contains the storage account for the data and the key vault for the connection to the sources. This should be very well protected and in principle should never be destroyed.
- **level 3**: This only contains Data Factory, which is some legacy, another team depended on it, so it shouldn't be destroyed. That team doesn't depend on it anymore, but the Data Factory still lives in this level.
- **level 4**: Contains the self hosted integration runtime, it takes a long time to deploy this, and it doesn't change that often.
- **level 5**: Contains databricks. This resource should not be destroyed that often, but it's also not too detrimental when it is destroyed.
- **level 6**: Contains infrastructure components that can be redeployed somewhat easily.
- **level 7**: Contains the final layer of the platform like access policies and role assignments, but also the Data Pipelines in Data Factory, so this has to be redeployed often.

# Release strategy

This code repository uses three Azure DevOps pipelines: `pull-request`, `generate-tag` and `release` which are defined 
in `/cicd` folder.
The strategy below explains how these three pipelines interact with each other and how this enables a smooth developer 
and release process.

## Pull request

Since the codebase is version controlled with Git, new incoming changes (on feature branches) should always be merged into 
the main branch using a pull requests. Before a pull request can be completed, the `pull-request` pipeline 
has to be completed successfully.

When it fails it means that the incoming codebase didn't adhere the predetermined standards. 
- Linting
- Formatting
- Documentation
- Testing (not available yet, due to complexity of testing infrastructure)

_Extra: The `/utils` directory contains scripts that can be used during local development to make sure the code adheres to the predetermined standards to avoid unnecessary pipeline failures during running of the `pull-request` pipeline in Azure DevOps._ 

## Pull request description

As part of the pull request an external pipeline will be triggerd which evaluates the description of the pull request.
This description should adhere to Conventional Commit style which means the first line should look something like 
this: `fix: implemented changes`. Since this pipeline is specified in another repository, we won't cover it fully here.

## Generate tag

After a pull request is completed git creates a so called 'merge commit' on the main branch, which triggers the `generate-tag` pipeline.  
_This pipeline is also triggered by 'normal' commits on the main branch._

The `generate-tag` pipeline uses Semantic Release.
It fetches all commit messages and analyses them to determine if a new release tag should be created.
All commits formatted according to the Conventional Commit style are evaluated, and a new release tag is determined and created if necessary.  
_For example: `fix: I changed some things` would result in a patch version increase, from v1.3.5 towards v1.3.6_

## Release

When a new tag is created in git, the `release` pipeline is automatically triggered.
This pipeline bundles the environment configuration into one `.zip` file and uploads this file to Artifactory under the 
version specified in the created tag.  
After this is completed the release process of this repository is done, and 
the new version could be picked up and deployed towards one of the environments.  
_This last step happens in a different repository (data-platform-env-config)._

# How to run the project

Normally, the infrastructure is deployed through (automatic) Azure DevOps pipelines.
The logic for this, however, lives in another repository, so we won't cover that here.

## Environment Variables

The Terragrunt configuration uses environment variables (for various reasons) in its deployment. They __must__ be set, 
otherwise Terragrunt won't be able to deploy to the environment.
To set an environment variable in PowerShell run: `$env:variable_name="variable_value"`.  
The following is the list of environment variables used during deployment.

<details>
   <summary>ARM_SUBSCRIPTION_ID</summary>

> Used by Terraform natively to connect using the Azure provider.  
> Subscription ID of the Meta subscription.  
> This is the subscription where the storage account lives where the tfstate files are stored on.

</details>
<details>
   <summary>ARM_CLIENT_ID</summary>

> Used by Terraform natively to connect using the Azure provider.  
> Client ID of the Meta subscription.  
> This is the subscription where the storage account lives where the tfstate files are stored on.

</details>
<details>
   <summary>ARM_CLIENT_SECRET</summary>

> Used by Terraform natively to connect using the Azure provider.  
> Client secret matching the specified client ID to access the Meta subscription.  
> This is the subscription where the storage account lives where the tfstate files are stored on.

</details>
<details>
   <summary>ARM_TENANT_ID</summary>

> Used by Terraform natively to connect using the Azure provider.  
> Tenant ID of the Meta subscription.  
> This is the subscription where the storage account lives where the tfstate files are stored on.  
> Note: This value is the same for all subscriptions.

</details>

<details>
   <summary>TFSTATE_RESOURCE_GROUP_NAME</summary>

> Name of the resource group where the storage account lives where the tfstate files are stored on.

</details>
<details>
   <summary>TFSTATE_STORAGE_ACCOUNT_NAME</summary>

> Name of the storage account the tfstate files are stored on.

</details>

<details>
   <summary>CLIENT_SECRET</summary>

> Client secret from the environment you want to deploy to.

</details>
<details>
   <summary>ENVIRONMENT_VERSION</summary>

> 3 digit string representation of the environment version, for example "001".  
> This can be found in the configuration file in the 'data-platform-env-config' repository.  
> This is usually used in names for ADF resources, for example the resource group 'rg-lpdapv001-dev'.

</details>
<details>
   <summary>ARTIFACT_DIR_PATH</summary>

> Path to the directory where the downloaded Artifactory artifact is extracted.
> This directory should contain a 'logic' and a 'pipelines' directory, each containing their respective artifacts.

</details>
<details>
   <summary>TERRAGRUNT_TERRAFORM_DIR</summary>

> Full path to the terraform directory containing the `modules` and `environments` directories.  
> This directory should be located in the root of this repository.

</details>
<details>
   <summary>NNDAP_PYPI_PAT</summary>

> PAT used to access the PyPI of NNDAP (PAT found here: "https://dev.azure.com/nn-dap/Innersource/_git/nndap-infra?path=/terraform/variables.tf")

</details>

## Deploy an environment (manually)

___Note__: This should ideally be done through the Azure DevOps pipelines, only this manually because a manual intervention is needed._

1. Navigate to the environment to be deployed (for example 'dev'): `/terraform/environments/dev/`
2. Set the required environment variables as described above.
3. Run `terragrunt run-all apply`

> A part of the environment can be deployed, destroyed or updated by navigating to a subdirectory of the environment during step 1.  
> This is exceptionally useful if not the whole platform should be destroyed or if a deployment went wrong and a manual intervention is needed.

## Useful commands

- `terragrunt run-all apply --terragrunt-ignore-external-dependencies`: useful when not deploying the whole environment.  
- `terragrunt run-all apply --terragrunt-include-dir <path/to/dir>`: useful when a specific part of the platform needs to be deployed, and you also want to deploy all required dependencies.
- `terragrunt run-all apply --terragrunt-include-module-prefix`: this flag shows the terragrunt module for each line in the output log, which makes it easier to debug, since it's visible what line belongs to what module.

# Domain Split Refactor Legacy

The platforms are split into multiple Data Domains (customer_workflow, finance, individual, pensions).
Before, there was only one platform, we call this the 'centralized' platform (and after the split 'decentralized').
We still need to maintain the centralized solution for some time, and this has lead to some legacy in the codebase that should be cleaned up later:

## Terragrunt Environment Layout

In the Terragrunt environments, there should only be the `platform` directory and the Data Domain directories like `customer_workflow`, `individual`, `pensions`.
There is also a `terragrunt.hcl` file in each data domain directory, which contains some base configuration for the platforms.
In each environment there is a `variables.yaml` file containing some variables for the different platforms.

In the sandbox (sbx) environment, each platform engineer has their own 'domain'.
This means that they can develop and deploy in parallel, without interference from eachother.

In the predev environment, there are several test environments created to be able to test our changes in a production like environment without hurting the data engineers.


# Common Pitfalls

- When renaming a directory in the Terragrunt configuration, the tfstate file will be saved on a different path as well, so you can't easily run a 'redeploy' using an apply in that case.
  In these situations you should run a destroy using the 'old' implementation and an apply using the 'new' implementation.

- We are for some parts heavily dependent on NNDAP (still).
  They, for example, changed a secret in [their code](https://dev.azure.com/nn-dap/Innersource/_git/data_factory?path=/modules/self_hosted_integration_runtime/virtual_machine/files/gatewayInstall.ps1&version=GBmain), which we had to copy-paste into ours to fix an authorization issue.

# FAQ



<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->