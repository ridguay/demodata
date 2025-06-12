$vaultName = "kv-lpdapv001-meta-envs"
$organization = "NN-Life-Pensions"
$project = "LPDAP_Azure"
$team = "LPDAP-Platform"
$workItemType = 'User%20Story'
$title = "Expiring Secrets Alert"
$description = "The following secrets are expiring soon:"

# Check for secrets expiring in the next 30 days, adjust as needed
$checkDaysAhead = 30

#######################################################################################################
# Function to create a work item in Azure DevOps
function createAzureWorkItem {
    param (
        [string]$organization,
        [string]$project,
        [string]$team,
        [string]$workItemType,
        [string]$title,
        [string]$description,
        [string]$expiringSecretsFmt,
        [string]$vaultName,
        [string]$patSecretName
    )

    # Retrieve the PAT from Azure Key Vault
    $pat = Get-AzKeyVaultSecret -VaultName $vaultName -Name $patSecretName -AsPlainText    
    $converted_pat = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

    $AzureDevOpsAuthenicationHeader = @{
        "Content-Type" = "application/json-patch+json"
        "Authorization" = "Basic $converted_pat"
    }


    # Get all iterations (sprints)
    $iterations_uri = "https://dev.azure.com/$organization/$project/$team/_apis/work/teamsettings/iterations?api-version=7.1"
    $iterations_response = Invoke-RestMethod -Uri $iterations_uri -Method Get -Headers $AzureDevOpsAuthenicationHeader

    # Find the next iteration
    $nextIteration = $iterations_response.value | Where-Object { $_.attributes.startDate -gt $(Get-Date) } | Sort-Object { $_.attributes.startDate } | Select-Object -First 1


    if ($nextIteration) {
        $nextIterationId = $nextIteration.id
        $nextIterationName = $nextIteration.name
        $nextIterationPath = $nextIteration.path
        } else {
            Write-Output "No upcoming iterations found."
    }


    # Create the work item using Azure DevOps REST API
    $uri = "https://dev.azure.com/$organization/$project/_apis/wit/workitems/`$$workItemType`?api-version=7.1"
    $body = @(
        @{
            "op" = "add"
            "path" = "/fields/System.Title"
            "value" = $title
        },
        @{
            "op" = "add"
            "path" = "/fields/System.Description"
            "value" = $description
        },
        @{
            "op" = "add"
            "path" = "/fields/Microsoft.VSTS.TCM.SystemInfo"
            "value" = $expiringSecretsFmt
        },
        @{
            "op" = "add"
            "path" = "/fields/System.IterationPath"
            "value" = $nextIterationPath
        }
    ) | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $AzureDevOpsAuthenicationHeader -Body $body

    Write-Output $response

    if ($response) {
        Write-Output "Work item created successfully: $($response.id)"
    } else {
        Write-Output "Failed to create work item."
    }
}

#######################################################################################################
# Get the list of secrets
$secrets = Get-AzKeyVaultSecret -VaultName $vaultName

# Display all secrets and their latest version expiry dates
Write-Output "Getting secrets from key vault..."
$secrets | ForEach-Object {
    $secret = $_
    $latestSecret = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secret.Name
    $expiryDate = $latestSecret.Attributes.Expires
    # if ($expiryDate) {
    #     Write-Output "Secret $($secret.Name) expires on $expiryDate"
    # } else {
    #     Write-Output "Secret $($secret.Name) has no expiry date"
    # }
}

# Check for secrets expiring in the next month
$nextMonth = (Get-Date).AddDays($checkDaysAhead)

$expiringSecrets = $secrets | ForEach-Object {
    $secret = $_
    $latestSecret = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secret.Name
    $expiryDate = $latestSecret.Attributes.Expires
    if ($expiryDate -and $expiryDate -le $nextMonth) {
        $latestSecret
    }
}

if ($expiringSecrets) {
    Write-Output "Secrets expiring in the next $checkDaysAhead days:"
    $expiringSecrets_fmt = "Secret Name".PadRight(40) + "Expiry Date`n"
    $expiringSecrets | ForEach-Object {
        $secret = $_
        $expiryDate = $secret.Attributes.Expires
        Write-Output "Secret $($secret.Name) is expiring on $expiryDate"
        $description += "`n- Secret $($secret.Name) is expiring on $expiryDate"
        $expiringSecrets_fmt += $secret.Name.PadRight(40) + "$expiryDate`n"
    }

    # Call the function to create the work item
    createAzureWorkItem -organization $organization -project $project -workItemType $workItemType -title $title -description $description -expiringSecretsFmt $expiringSecrets_fmt -vaultName $vaultName -patSecretName "meta-kv-secrets-expiry-pat"
} else {
    $expiringSecrets_fmt = "No secrets expiring in the next $checkDaysAhead days."
    Write-Output $expiringSecrets_fmt

    # Don't create a user story and exit
    exit 0
}