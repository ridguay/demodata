<#
.SYNOPSIS
	This Azure script creates all settings for the DataBricks -> HANA where HANA is able to retrieve data from all databricks 
    data domains and environments.

.DESCRIPTION
	This Azure script creates all settings for the DataBricks -> HANA where HANA is able to retrieve data from all databricks 
    data domains and environments.

    This script does the following

    - Creates a KeyVault with private endpoint in the LPDAP-Meta subscription for storing the passwords and tokens
    - Retrieve list of the created Enterprise Applications and uses this list to loop through all of these Enterprise Apps
      - Create a password for the Enterpise App (Valid for 2 years by default)
      - Store this password in the keyvault
      - Assign Contributer Role for the Enterprise Application to the Databricks Environment
      - Add Enterprise App (Service Principal) To databricks
      - Assign Create token rights to users group.
      - Generate a token for Enterprise App to access the the Databricks API
      - Generate a Databricks token for the Databricks Connection
      - Store this token in the keyvault (Valid for 2 years)

    Note : Run this script from your laptop, Powershell is needed and also the Az modules. Install-Module az
           Use your csa account with admin access to databricks and contributer role for databricks.
           $Credential = Get-Credential
           Connect-AzAccount -Credential $Credential

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>

# Create Azure Keyvault in LPDAP-Meta if needed.

#exit # stop script from being started by accident, because that will cause big issues.

$VaultSub = "LPDAP-Meta"
$VaultName = "kv-lpdapv001-conn"
$VaultRsg = "rg-lpdapv001-conn"
$VaultPEName  = "pe-lpdapv001-conn"
$VaultPENic  = "$VaultPE-nic"
$VaultSubnet = "snet-lpdapv001-meta-tfstate"

Set-AzContext -SubscriptionName $VaultSub | Out-Null

$VNetName = "NNANPSpoke-$VaultSub"

$KeyVault = Get-AzKeyVault -VaultName $VaultName -ResourceGroupName $VaultRsg

If ( $KeyVault -eq $Null ) {

    $RuleSet = New-AzKeyVaultNetworkRuleSetObject -DefaultAction Allow -Bypass AzureServices -IpAddressRange "8.25.203.0/24, 27.251.211.238/32, 64.74.126.64/26, 70.39.159.0/24, 72.52.96.0/26, 89.167.131.0/24, 104.129.192.0/20, 136.226.0.0/16, 137.83.128.0/18, 147.161.128.0/17, 165.225.0.0/17, 165.225.192.0/18, 185.46.212.0/22, 199.168.148.0/22, 213.152.228.0/24, 216.218.133.192/26, 216.52.207.64/26"

    $KeyVault = New-AzKeyVault -Name $VaultName -ResourceGroupName $VaultRsg -Location "WestEurope" -EnablePurgeProtection -EnableRbacAuthorization -SoftDeleteRetentionInDays 90 -NetworkRuleSet $RuleSet

    $VNetName = "NNANPSpoke-$VaultSub"

    $virtualNetwork = Get-AzVirtualNetwork -ResourceName $VnetName -ResourceGroupName "AzureVnet"
    $subnet = $virtualNetwork | Select-Object -ExpandProperty subnets | Where-Object Name -eq $VaultSubnet

    $KvId = (get-azresource -ResourceName $VaultName -ResourceGroupName $VaultRsg).id

    $plsConnection= New-AzPrivateLinkServiceConnection -Name $VaultPE -PrivateLinkServiceId $KvId -RequestMessage 'Please Approve my request' -GroupId "Vault"

    New-AzPrivateEndpoint -Name $VaultPEName -ResourceGroupName $VaultRsg -Location "WestEurope" -PrivateLinkServiceConnection $plsConnection -Subnet $subnet -CustomNetworkInterfaceName $VaultPENic

}

#$AppList = Get-AzADApplication | where-object {$_.DisplayName -Like "LPDAP-HANA*"}

# Following lines are used for development and testing.

#$AppList = Get-AzADApplication | where-object {$_.DisplayName -Like "LPDAP-HANA*"} | where-object {$_.DisplayName -like "*-PRD"}

$AppList = Get-AzADApplication -DisplayName "LPDAP-HANA-IND-REC"

#$AppList = Get-AzADApplication -DisplayName "LPDAP-HANA-CNW-DEV"

#$AppList = Get-AzADApplication -DisplayName "LPDAP-HANA-IND-DEV"

#$AppList = Get-AzADApplication -DisplayName "LPDAP-HANA-PNS-DEV"

ForEach ($App in $AppList) {

    $DatabricksToken = $Null

    $Name = ($App.DisplayName).Substring(11,($App.DisplayName).Length-11)
    $Domain = ($Name).SubString(0,($Name).IndexOf("-"))
    $Env    = ($Name).SubString(($Name).IndexOf("-")+1,3)

    Set-AzContext -SubscriptionName "LPDAP-$Environment" | Out-Null

    $DatabricksWS = Get-AzDatabricksWorkspace | where-object {$_.Name -like "*$Domain*"} 
    $DatabricksName = $DatabricksWS.Name
    $DatabricksUrl = $DatabricksWS.Url
    $AppObjectId   = (Get-AzADServicePrincipal -DisplayName $App.DisplayName).id
    $AppName       = $App.DisplayName
    $AppId         = $App.AppId
    $resource="2ff814a6-3304-4ab8-85cb-cd0e6f879c1d" # generic databricks resource id

    Write-Host "Creating Password for $AppName and storing it in the keyvault"

    $Secret = New-AzADAppCredential -ObjectId $App.id

    $SecureString = ConvertTo-SecureString -String ($Secret.SecretText) -AsPlainText -Force

    $SecretName = $App.DisplayName + "-Password"
    
    Set-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $SecretName -ContentType "Password" -Expires $Secret.EndDateTime -SecretValue $SecureString -ErrorAction Stop  | Out-Null

    # Add Azure Contributer Role for Enterprise App to databricks env

    If ((Get-AzRoleAssignment -ObjectId $AppObjectId -Scope $DatabricksWS.Id) -eq $Null) {

        Write-Host "Adding contributor role for $AppName to $DatabricksName"

        New-AzRoleAssignment -ApplicationId $App.AppId -Scope $DatabricksWS.Id -RoleDefinitionName "Contributor" | Out-Null

        Start-Sleep -Seconds 30
    }

    # Add Generate Token right to users group this has to be done with account that is member of admin group

    Write-Host "Creating token for current user to access Databricks API"
    
    $context = Get-AzContext
    
    $token = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account,
        $context.Environment, 
        $context.Tenant.Id.ToString(), 
        $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, $resource).AccessToken

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/token/create"

    $Headers = @{
        Authorization="Bearer $Token"; 
        "Content-Type"="application/json"
    }
    
    $DatabricksAdminToken = Invoke-RestMethod -Method POST -Uri $CompleteUrl -Headers $Headers -erroraction silentlycontinue

    # Add Enterprise App To Databricks

    Write-Host "Adding $AppName service principal to $DatabricksName using Databricks API"

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/preview/scim/v2/ServicePrincipals"

    $AdminToken = $DatabricksAdminToken.token_value

    $Headers = @{
        Authorization="Bearer $AdminToken"; 
        "Content-Type"="application/json"
    }

    $Body = '{
        "displayName": "' + $AppName + '",
        "groups": [],
        "entitlements": [
        "@{value=workspace-access}",
        "@{value=databricks-sql-access}",
        "@{value=allow-cluster-create}"
        ],
        "applicationId": "' + $AppId +'",
        "active": true
    }'
    try {
        Invoke-RestMethod -Method POST -Uri $CompleteUrl -Headers $Headers -body $Body  -erroraction silentlycontinue | Out-Null
    } catch {
        # Dig into the exception to get the Response details.
        # Note that value__ is not a typo.
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" (convertfrom-json $_.ErrorDetails.Message).detail
    }        


    # Assign Create token rights to users

    Write-Host "Assigning CAN_USE databricks tokens to users group in $DatabricksName using Databricks API"

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/preview/permissions/authorization/tokens"

    $Admintoken = $DatabricksAdminToken.token_value
    
    $Headers = @{
            Authorization="Bearer $AdminToken"; 
            "Content-Type"="application/json"
        }
    
    $body = '{ 
        "access_control_list": [ 
          { 
            "group_name": "users", 
            "permission_level": "CAN_USE" 
          }
        ] 
      }'
    
    Invoke-RestMethod -Method PATCH -Uri $CompleteUrl -Headers $Headers -body $body  -erroraction silentlycontinue | Out-Null

    # Generate Enterprise App Token

    Write-Host "Waiting 1 minute for Azure AD to catch up"

    Start-Sleep -Seconds 60 # Need to wait some time before login using the ServicePrincipal and generated password

    Save-AzContext -Path "current.json" -Force | Out-Null

    Write-Host "Login in using the $AppName to Azure to generate Azure Access Token"

    $tenantId = "fed95e69-8d73-43fe-affb-a7d85ede36fb"
    $pscredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $App.AppId, $SecureString

    Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenantId | Out-Null
    
    $Context = Get-AzContext
    
    $token = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account,
        $context.Environment, 
        $context.Tenant.Id.ToString(), 
        $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, $resource).AccessToken
    
    Import-AzContext -path "current.json" | Out-Null

    Write-Host "Generating Databricks Access token for $AppName to $DatabricksName and storing it in the keyvault"

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/token/create"

    $Headers = @{
        Authorization="Bearer $Token"; 
        "Content-Type"="application/json"
    }

    $DatabricksToken = Invoke-RestMethod -Method POST -Uri $CompleteUrl -Headers $Headers -erroraction silentlycontinue
    Write-Host ""
    Write-Host "AD Enterprise App    : " -ForegroundColor Yellow -NoNewline
    Write-Host $App.DisplayName
    Write-Host "AD Enterprise App id : " -ForegroundColor Yellow -NoNewline
    Write-Host $App.Appid
    Write-Host "Keyvault used        : " -NoNewline -ForegroundColor Yellow
    Write-Host $KeyVault.VaultName
    Write-Host "DataBricks Name      : " -ForegroundColor Yellow -NoNewline
    Write-Host $DatabricksName
    Write-Host "DataBricks URL       : " -ForegroundColor Yellow -NoNewline
    Write-Host $DatabricksUrl
    Write-Host "Token                : " -ForegroundColor Yellow -NoNewline
    Write-Host $DatabricksToken.token_value

    $SecretName = $App.DisplayName + "-Token"

    If ($DatabricksToken -ne $Null) {

        $SecureString = ConvertTo-SecureString -String ($DatabricksToken.token_value) -AsPlainText -Force

        Set-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $SecretName -ContentType "Token" -Expires (Get-Date).AddYears(2) -SecretValue $SecureString -ErrorAction Stop  | Out-Null

    }
    Write-Host ""

}

