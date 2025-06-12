$DatabricksUrl = "adb-1340041590126075.15.azuredatabricks.net"
$ClusterId = "0830-100831-gz03o9nl"

    $CompleteUrl = "https://$DatabricksUrl/api/2.0/clusters/start"
    $Token = "<token from key vault>"

    $Headers = @{
            Authorization="Bearer $Token"; 
            "Content-Type"="application/json"
        }

    $Body = '{
        "cluster_id": "'+ $ClusterId + '"
      }
      '


Invoke-RestMethod -Method POST -Uri $CompleteUrl -Headers $Headers -Body $Body -Erroraction silentlycontinue