<#
.SYNOPSIS
	This Azure script check the java version installed on vm's.

.DESCRIPTION
    This Azure script check the java version installed on vm's.

    This is an easy way to check if java has been properly installed on all vm's after for example an upgrade. 
    This runs 'java -version' on every vm in all subscriptions.

    You will need to login to Azure before running this script and also have Az modules v12.0 installed.

    You login to this like

    Connect-AzAccount

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>


# List of subscriptions

$SubScriptionList = @("LPDAP-Meta",
                      "LPDAP-SBX",
                     "LPDAP-PREDEV",
                      "LPDAP-DEV",
                      "LPDAP-TST",
                      "LPDAP-ACC",
                      "LPDAP-PRD"
                      )

#Connect-AzAccount

ForEach ($SubScription in $SubScriptionList) {

    Set-AzContext -SubscriptionName $SubScription | Out-Null

    Write-Host ""
    Write-Host $SubScription
    Write-Host ""    

    $VMList = Get-AzVM

    ForEach($VM in $VMList) {

        If ((get-azvm -ResourceGroupName $VM.ResourceGroupName -name $VM.Name).StorageProfile.OsDisk.OsType -eq "Windows") {
            Write-Host $VM.Name
            (Invoke-AzVMRunCommand -ResourceGroupName $VM.ResourceGroupName -VMName $VM.Name -CommandId "RunPowerShellScript" -ScriptString "java -version").Value[1].Message
            Write-Host ""
        }

    }

}