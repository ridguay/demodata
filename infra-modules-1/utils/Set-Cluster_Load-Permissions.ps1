
$VaultName = "kv-lpdapv001-conn"

$AppList = Get-AzADApplication | where-object {$_.DisplayName -Like "LPDAP-HANA*"} | where-object {$_.DisplayName -like "*-TST"}

ForEach ($App in $AppList) {

    $Name = ($App.DisplayName).Substring(11,($App.DisplayName).Length-11)
    $Domain = ($Name).SubString(0,($Name).IndexOf("-"))
    $Env    = ($Name).SubString(($Name).IndexOf("-")+1,3)


    Set-AzContext -SubscriptionName "LPDAP-$Environment" | Out-Null

    $DatabricksWS = Get-AzDatabricksWorkspace | where-object {$_.Name -like "*$Domain*"} 
    $DatabricksUrl = $DatabricksWS.Url
    $AppName = $App.DisplayName
    $AppId   = $App.AppId
    $resource="2ff814a6-3304-4ab8-85cb-cd0e6f879c1d" # generic databricks resource id
  
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

    # Assign Create token rights to users

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/clusters/list"

    $Admintoken = $DatabricksAdminToken.token_value
    
    $Headers = @{
            Authorization="Bearer $AdminToken"; 
            "Content-Type"="application/json"
        }
    
    try {
        $Clusterlist = Invoke-RestMethod -Method GET -Uri $CompleteUrl -Headers $Headers -erroraction silentlycontinue
        $Cluster = $ClusterList.clusters | Where-object {$_.Cluster_name -eq "cluster_load"}
    } catch {
        # Dig into the exception to get the Response details.
        # Note that value__ is not a typo.
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" (convertfrom-json $_.ErrorDetails.Message).detail
    }        

    $ClusterId=$cluster.cluster_id

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/permissions/clusters/$ClusterId"

    $Admintoken = $DatabricksAdminToken.token_value

    # https://learn.microsoft.com/en-us/azure/databricks/security/auth-authz/access-control/cluster-acl
    
    $Body = '{
        "access_control_list": [
          {
            "service_principal_name": "' + $AppId + '",
            "permission_level": "CAN_RESTART"
          }
        ]
      }'
      
    try {
        $ClusterPerms = Invoke-RestMethod -Method PATCH -Uri $CompleteUrl -Headers $Headers -Body $Body -Erroraction silentlycontinue
        $ClusterPerms

    } catch {
        # Dig into the exception to get the Response details.
        # Note that value__ is not a typo.
        Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "StatusDescription:" (convertfrom-json $_.ErrorDetails.Message).detail
        Write-Host $_.Exception
    }        



}