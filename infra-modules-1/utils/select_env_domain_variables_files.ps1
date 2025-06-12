# Define the environments and domains
$environments = "dev", "acc", "tst", "prd", "adf-as-a-service-acc", "adf-as-a-service-tst", "adf-as-a-service-prd", "adf-as-a-service-dev"
$domains = "customer_workflow", "individual", "pensions", "mall_main"
$domainsAsAService = "financial_life_individual"

# Function to display a menu and return the selected item
function Select-Item {
    param([string[]]$items)

    # Display the menu
    for ($i = 0; $i -lt $items.Length; $i++) {
        Write-Host "$($i+1). $($items[$i])"
    }

    # Get the user's selection
    $selection = Read-Host "Please select an item by number (1-$($items.Length))"

    # Return the selected item
    return $items[$selection-1]
}

# Get the Terraform root path
$terraformRootPath = Read-Host "Please enter the Terraform root path" # Or fill in the value

# Get the selected environment and domain
$selectedEnvironment = Select-Item -items $environments

# Check if the selected environment is ADF as a Service
if ($selectedEnvironment -like "*adf-as-a-service*") {
    $domains = $domainsAsAService
}
$selectedDomain = Select-Item -items $domains

switch ($selectedEnvironment) {
    "prd" {
        # Add your values for the 'prd' environment here
        $env:ARM_SUBSCRIPTION_ID="8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b"
        $env:ARM_CLIENT_ID="3e76b4bb-79aa-479b-98d4-1d053cf883e7"
        $env:ARM_CLIENT_SECRET=#Fill in the value
        $env:ARM_TENANT_ID="fed95e69-8d73-43fe-affb-a7d85ede36fb"
        $env:TFSTATE_RESOURCE_GROUP_NAME="rg-lpdapv001-meta"
        $env:TFSTATE_STORAGE_ACCOUNT_NAME="stlpdapv001metatfstate"
        $env:TERRAGRUNT_TERRAFORM_DIR=#Fill in the value
        $env:ARTIFACT_DIR_PATH=#Fill in the value
        $env:NNDAP_PYPI_PAT=#Fill in the value
        $env:ENVIRONMENT_VERSION="001"

        $env:CLIENT_SECRET=#Fill in the value

        Write-Host "Selected environment: prd"
    }
    "acc" {
        # Add your values for the 'acc' environment here
        $env:ARM_SUBSCRIPTION_ID="8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b"
        $env:ARM_CLIENT_ID="3e76b4bb-79aa-479b-98d4-1d053cf883e7"
        $env:ARM_CLIENT_SECRET=#Fill in the value
        $env:ARM_TENANT_ID="fed95e69-8d73-43fe-affb-a7d85ede36fb"
        $env:TFSTATE_RESOURCE_GROUP_NAME="rg-lpdapv001-meta"
        $env:TFSTATE_STORAGE_ACCOUNT_NAME="stlpdapv001metatfstate"
        $env:PAYLOAD_DIR=#Fill in the value
        $env:NOTEBOOKS_DIR_PATH=#Fill in the value
        $env:PACKAGE_WHL_DIR=#Fill in the value
        $env:TERRAGRUNT_TERRAFORM_DIR=#Fill in the value
        $env:NNDAP_PYPI_PAT=#Fill in the value
        $env:ENVIRONMENT_VERSION="01"
        $env:ARTIFACT_DIR_PATH=#Fill in the value
        $env:CLIENT_SECRET=#Fill in the value
        Write-Host "Selected environment: acc"
    }
    "dev" {
        # Add your values for the 'dev' environment here
        $env:ARM_SUBSCRIPTION_ID="8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b"
        $env:ARM_CLIENT_ID="3e76b4bb-79aa-479b-98d4-1d053cf883e7"
        $env:ARM_CLIENT_SECRET=#Fill in the value
        $env:ARM_TENANT_ID="fed95e69-8d73-43fe-affb-a7d85ede36fb"
        $env:TFSTATE_RESOURCE_GROUP_NAME="rg-lpdapv001-meta"
        $env:TFSTATE_STORAGE_ACCOUNT_NAME="stlpdapv001metatfstate"
        $env:PAYLOAD_DIR=#Fill in the value
        $env:NOTEBOOKS_DIR_PATH=#Fill in the value
        $env:PACKAGE_WHL_DIR=#Fill in the value
        $env:TERRAGRUNT_TERRAFORM_DIR=#Fill in the value
        $env:NNDAP_PYPI_PAT=#Fill in the value
        $env:CLIENT_SECRET=#Fill in the value
        $env:ARTIFACT_DIR_PATH=#Fill in the value
        $env:ENVIRONMENT_VERSION="01"
        Write-Host "Selected environment: dev"
    }
    "tst" {
        # Add your values for the 'tst' environment here
        $env:ARM_SUBSCRIPTION_ID="8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b"
        $env:ARM_CLIENT_ID="3e76b4bb-79aa-479b-98d4-1d053cf883e7"
        $env:ARM_CLIENT_SECRET=#Fill in the value
        $env:ARM_TENANT_ID="fed95e69-8d73-43fe-affb-a7d85ede36fb"
        $env:TFSTATE_RESOURCE_GROUP_NAME="rg-lpdapv001-meta"
        $env:TFSTATE_STORAGE_ACCOUNT_NAME="stlpdapv001metatfstate"
        $env:PAYLOAD_DIR=#Fill in the value
        $env:NOTEBOOKS_DIR_PATH=#Fill in the value
        $env:PACKAGE_WHL_DIR=#Fill in the value
        $env:TERRAGRUNT_TERRAFORM_DIR=#Fill in the value
        $env:NNDAP_PYPI_PAT=#Fill in the value
        $env:ENVIRONMENT_VERSION="01"
        $env:ARTIFACT_DIR_PATH=#Fill in the value
        $env:CLIENT_SECRET=#Fill in the value
        Write-Host "Selected environment: tst"
    }
    default {
        Write-Host "Selected environment: $selectedEnvironment"
    }
}


# Build the paths to the configuration files
$env:ENV_CONFIGURATION_FILE = Join-Path -Path $terraformRootPath -ChildPath "environments\$selectedEnvironment\env_configuration.yaml"
$env:DOMAIN_CONFIGURATION_FILE = Join-Path -Path $terraformRootPath -ChildPath "environments\$selectedEnvironment\$selectedDomain\domain_configuration.yaml"
$env:PLATFORM_CONFIGURATION_FILE = Join-Path -Path $terraformRootPath -ChildPath "environments\$selectedEnvironment\platform\platform_configuration.yaml"

# Output the selected values and paths

Write-Host "Selected domain: $selectedDomain"
Write-Host "ENV_CONFIGURATION_FILE: $env:ENV_CONFIGURATION_FILE"
Write-Host "DOMAIN_CONFIGURATION_FILE: $env:DOMAIN_CONFIGURATION_FILE"
Write-Host "PLATFORM_CONFIGURATION_FILE: $env:PLATFORM_CONFIGURATION_FILE"
