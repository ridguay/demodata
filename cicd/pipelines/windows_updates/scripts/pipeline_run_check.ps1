<#
.SYNOPSIS
	This script will check if today is a patch day.

.DESCRIPTION
	This script will check if today is a patch day and will set a Azure DevOps variable to run the windows update stages.
    dev = Second Wednesday
    tst = Second Thursday
    Acc = Second Saturday
    Prd = Third Saturday

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>

$TodayDate = (Get-Date).Date

# Get-Date -Day 12 # Determine starting point
$BaseDate = ( Get-Date -Day 12 ).Date
# $BaseDate.DayOfWeek # Determine day of the week
# Get actual Patch Tuesday for the month
$PatchTuesday = $BaseDate.AddDays( 2 - [int]$BaseDate.DayOfWeek )

# Set variables for our various environments patch schedule
$devPatchWednesday = $PatchTuesday.AddDays(1)
$tstPatchThursday = $PatchTuesday.AddDays(2)
$accPatchSaturday = $PatchTuesday.AddDays(4)
$prdPatchSaturday = $PatchTuesday.AddDays(11)


Write-Host "Dev : $devPatchWednesDay"
Write-Host "Tst : $tstPatchThursday"
Write-Host "Acc : $accPatchSaturday"
Write-Host "Prd : $prdPatchSaturday"

If (($TodayDate -eq $devPatchWednesday) -or ($TodayDate -eq $tstPatchThursday) -or ($TodayDate -eq $accPatchSaturday) -or ($TodayDate -eq $prdPatchSaturday)) {
    Write-Host "It is patch day. InstallUpdates=True"
    Write-Host "##vso[task.setvariable variable=InstallUpdates;isoutput=true]true"
} Else {
    Write-Host "It is NOT patch day. InstallUpdates=False"
    Write-Host "##vso[task.setvariable variable=InstallUpdates;isoutput=true]false"
}
