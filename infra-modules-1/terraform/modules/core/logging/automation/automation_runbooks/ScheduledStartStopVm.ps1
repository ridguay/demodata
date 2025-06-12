
param(
    [parameter(Mandatory=$false)]
    [string] $environmentName = "AzureCloud",   
    
    [parameter(Mandatory=$false)]
    [string] $resourceGroupName,

    [parameter(Mandatory=$false)]
    [string] $VMName,
    
    [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Start", "Stop","Restart")]
        [string]    $Action
    
    )
    
    # Changing the errorActionPreference to stop, this fails the runbook if any error occurs.

$errorActionPreference = "Stop"

filter timestamp {"[$(Get-Date -Format G)]: $_"}

Write-Output "Script started." | timestamp

# Authentication using Automation Identity

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process | Out-Null

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

Write-Output "Authenticated with Automation Identity."  | timestamp

If (!$VMName) {

    If (!$resourceGroupName) {
        $vms = Get-AzVM
        # Check if first VM in the list is the DC
        If ($vms[0].Name -notlike "*-dc-*") {
            $vms = Get-AzVM | Sort-Object -Property Name -Descending
            }
    } Else {
        $vms = Get-AzVM -resourcegroupname $resourceGroupName 
        # Check if first VM in the list is the DC
        If ($vms[0].Name -notlike "*-dc-*") {
            $vms = Get-AzVM -resourcegroupname $resourceGroupName | Sort-Object -Property Name -Descending
            }
        }
} Else {
    $vms = Get-AzVM -Name $VMName
}


Switch ( $Action.ToLower() ) {

    "start" {
        $vmname = $vm.name 
        $vmresourceGroupName = $vm.resourceGroupName

        ForEach ($vm in $vms) {
            $vmname = $vm.name 
            $vmresourceGroupName = $vm.resourceGroupName

            Write-Output "Starting $vmname in resoursegroup $vmresourceGroupName" | timestamp
            $result = Start-AzVM -name $vmname -ResourceGroupName $vmresourceGroupName -Confirm:$False
            Write-Output "$vmname in resoursegroup $vmresourceGroupName has been started" | timestamp
            Write-Output $result
            Start-Sleep -Seconds 30
        }
    }
    
    "stop" {
        ForEach ($vm in $vms) {
            $vmname = $vm.name 
            $vmresourceGroupName = $vm.resourceGroupName

            Write-Output "Stopping $vmname in resoursegroup $vmresourceGroupName" | timestamp
            $result = Stop-AzVM -name $vmname -ResourceGroupName $vmresourceGroupName -Confirm:$False -Force
            Write-Output "$vmname in resoursegroup $vmresourceGroupName has been stopped" | timestamp
            Write-Output $result
            Start-Sleep -Seconds 30
        }

    }

    "restart" {
        ForEach ($vm in $vms) {
            $vmname = $vm.name 
            $vmresourceGroupName = $vm.resourceGroupName

            Write-Output "Restart $vmname in resoursegroup $vmresourceGroupName" | timestamp
            $result = Restart-AzVM -name $vmname -ResourceGroupName $vmresourceGroupName -Confirm:$False 
            Write-Output "$vmname in resoursegroup $vmresourceGroupName has been restarted" | timestamp
            Write-Output $result
            Start-Sleep -Seconds 30
        }
    }

}

Write-Output "Script finished." | timestamp
