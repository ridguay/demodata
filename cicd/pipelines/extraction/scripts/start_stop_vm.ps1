<#
.SYNOPSIS
	This script will check if and ensure that the VM that is used for a Self-hosted Integration Runtime is turned on/off.

.DESCRIPTION
	TODO: add description

.PARAMETER DataDomainShort
    The abbreviation of the DataDomain to update. For example: ind, cnw, pns.

.PARAMETER Environment
    Specify the environment to use. For example: sbx, pdx, dev, tst, acc or prd.

.PARAMETER VMTargetState
    The target allocation state (on/off) of the VM: either "Running" or "Stopped".

.PARAMETER WaitTimeInSeconds
    How long to wait after the VM is turned on (in seconds) to ensure the Shared Integration Runtime is available.
    Only used when the VM target state is running. Defaults to 60 seconds (1 minute).

.INPUTS
	None.

.OUTPUTS
    One output indicates whether or not the VM was turned on during execution of this script.
    This output is set as a variable in Azure DevOps so it can be used by the next task.
    If the VM has been turned on, that task will turn the VM back off after deployment has finished.
	Also some human-readable informational and error messages produced during the job.

#>

Param (
    [Parameter(Mandatory=$true)][string]$DataDomainShort,
    [Parameter(Mandatory=$true)][string]$Environment,
    [Parameter(Mandatory=$false)][string]$VMTargetState = "Running",
    [Parameter(Mandatory=$false)][int]$WaitTimeInSeconds = 60
)

$VMName = "vmshir${DataDomainShort}01${Environment}1"
$ResourceGroupName = "rg-lp${DataDomainShort}01-${Environment}"
Write-Output "Checking if SHIR VM $VMName in $ResourceGroupName is turned ${VMTargetState}..."

$VMPowerState = (Get-AzVM -VMName $VMName -Status).PowerState
$IsVMTurnedOn = ($VMPowerState -eq "VM running")

Write-Output "Current Status of ${VMName}: ${VMPowerState}. Is turned on: ${IsVMTurnedOn}"

If ($IsVMTurnedOn -and $VMTargetState -eq "Stopped") {
    Write-Output "Stopping $VMName..."
    Stop-AzVM -Name $VMName -ResourceGroupName $ResourceGroupName -Force | Out-Null
    Write-Output "${VMName} stopped."
}

If (-not $IsVMTurnedOn -and $VMTargetState -eq "Running") {
    Write-Output "Starting ${VMName}..."
    Start-AzVM -Name $VMName -ResourceGroupName $ResourceGroupName | Out-Null
    Write-Output "${VMName} started."
    Write-Output "Sleeping for ${WaitTimeInSeconds} seconds to ensure SHIR is available."
    Start-Sleep -Seconds $WaitTimeInSeconds
    Write-Host "Setting output variable: vso[task.setvariable variable=VMTurnedOn]true"
    Write-Host "##vso[task.setvariable variable=VMTurnedOn]true"
} Else {
    Write-Host "Setting output variable: vso[task.setvariable variable=VMTurnedOn]false"
    Write-Host "##vso[task.setvariable variable=VMTurnedOn]false"
}

Write-Output "Done."
