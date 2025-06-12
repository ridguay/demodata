
$VaultName = "kv-lpdapv001-conn"

$AppList = Get-AzADApplication | where-object {$_.DisplayName -Like "LPDAP-HANA*"} | where-object {$_.DisplayName -like "*-TST"}

ForEach ($App in $AppList) {

    $Name = ($App.DisplayName).Substring(11,($App.DisplayName).Length-11)
    $Domain = ($Name).SubString(0,($Name).IndexOf("-"))
    $Env    = ($Name).SubString(($Name).IndexOf("-")+1,3)

    Set-AzContext -SubscriptionName "LPDAP-$Environment" | Out-Null

    $DatabricksWS = Get-AzDatabricksWorkspace | where-object {$_.Name -like "*$Domain*"} 
    $DatabricksWSid = $DatabricksWS.WorkspaceId
    $DatabricksUrl = $DatabricksWS.Url
    $SecretName = $App.DisplayName + "-Token"
    $resource="2ff814a6-3304-4ab8-85cb-cd0e6f879c1d" # generic databricks resource id

    $PrincipalToken = Get-AzKeyVaultSecret -VaultName $VaultName -Name $SecretName -AsPlainText
  
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

    # jdbc:spark://<db-hostname>:443/default;transportMode=http;ssl=1;httpPath=sql/protocolv1/o/<workspace-id>/<cluster-id>;AuthMech=3;UID=token;PWD=<personal-access-token>
    # sql/protocolv1/o/1340041590126075/0830-100831-gz03o9nl

    $ClusterId=$cluster.cluster_id

    $HTTPPath = "sql/protocolv1/o/$Databrickswsid/$ClusterId"

    $Config = '
[Databricks_'+ $Env + '_' + $Domain + ']
Driver=<DRIVER PATH on server>
HOST=' + $DatabricksUrl + '
PORT=443
HTTPPath='+ $HTTPPath + '
ThriftTransport=2
SSL=1
AuthMech=3
UID=token
PWD=' + $PrincipalToken + '
AllowSelfSignedServerCert=1
CAIssuedCertNamesMismatch=1'

    Write-Host $Config

}