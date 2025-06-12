<#
.SYNOPSIS
	This script will install Windows Updates on VM's according to the schedule in the pipeline.

.DESCRIPTION
	This script will install Windows Updates on VM's according to the schedule in the pipeline. The script uses on parameter to specify the 
    data domain to update. This is specified in DataDomainShort

.PARAMETER DataDomainShort
    The abbreviation of the DataDomain to update. For Example ind, cnw, pns, mall. Specify * for every data domain in the subscription

.PARAMETER RebootSetting
    Specify of the VM's should be rebooted after installing the updates. Specify "Allways" to enabled reboot if required by the updates. 
    "Never" is the default setting.

.PARAMETER Environment
    Specify the environment to use (sbx, pdx, dev, tst, acc and prd). This is used to determine the day to run.
    sbx/pdv = Second Tuesday (Patch Tuesday)
    dev = Second Wednesday
    tst = Second Thursday
    Acc = Second Saturday
    Prd = Third Saturday

.PARAMETER Force
    Specify if the check for Maintenance window should be skipped.

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>

Param (
    [Parameter(Mandatory=$false)][string]$DataDomainShort = "*",
    [Parameter(Mandatory=$false)][string]$RebootSetting = "Never",
    [Parameter(Mandatory=$false)][string]$Environment = "pdv",
    [Parameter(Mandatory=$false)][boolean]$Force = $False
)

Function Get-PatchDate
{
    param (
        [string[]]$Env,
        [string[]]$TimeZone,
        [Int]$StartHour
    )

    $Now = [System.DateTime]::Now
    $FirstOfMonth = [System.DateTime]::new($Now.year, $Now.Month, 1, $StartHour, 0, 0)
    $tz = Get-TimeZone -Id $ScheduleTimezone
   
    switch ($env) {
        "dev" { # Second Wednesday
            $PatchDay = $FirstOfMonth.AddDays((8..14)[2-($FirstOfMonth.DayOfWeek.value__)])
        }
        "tst" { # Second Thursday
            $PatchDay = $FirstOfMonth.AddDays((8..14)[3-($FirstOfMonth.DayOfWeek.value__)])
        }
        "acc" { # Second Saterday
            $PatchDay = $FirstOfMonth.AddDays((8..14)[5-($FirstOfMonth.DayOfWeek.value__)])
        }
        "prd" { # Third Saterday
            $PatchDay = $FirstOfMonth.AddDays((15..21)[5-($FirstOfMonth.DayOfWeek.value__)])
        }
        default {
            $PatchDay = $FirstOfMonth.AddDays((8..14)[1-($FirstOfMonth.DayOfWeek.value__)])
        }
    }

    $PatchDayDTO = [System.DateTimeOffset]::new($PatchDay, $tz.GetUtcOffset($PatchDay))

    Return $PatchdayDTO

}

Write-Output "Param DataDomainshort : $DataDomainShort"
Write-Output "Param RebootSetting   : $RebootSetting"
Write-Output "Param Force           : $Force"
Write-Output "Retrieving Maintenance Configuration Settings"

If ($DataDomainShort -eq "*") {
    $MaintenanceConfigurationList = Get-AzMaintenanceConfiguration
} else {
    $MaintenanceConfigurationList = Get-AzMaintenanceConfiguration | where-object {$_.Name -like "*$DataDomainShort*"}
}

If ($MaintenanceConfigurationList.length -gt 0) {

    $ScheduleStartTime = $MaintenanceConfigurationList[0].StartDateTime
    $ScheduleStartHour = ([DateTime]$ScheduleStartTime).Hour
    $ScheduleTimezone  = $MaintenanceConfigurationList[0].Timezone

    $PatchDatetime = Get-PatchDate -Env $Environment -TimeZone $ScheduleTimezone -StartHour $ScheduleStartHour
    $CurrentDatetime = [System.DateTimeOffset]::Now;

    If ((($CurrentDatetime -gt $PatchDatetime) -and ($CurrentDatetime -lt $PatchDatetime.AddMinutes(15))) -or $Force) {

        Write-OutPut "Script started in side the patch window $PatchDatetime.DateTime (+15min)"
        If ($Force) {
            Write-OutPut "Force Windows updates installation was enabled."
        }
        $ResourceGroupName = (Get-AzResource -id $MaintenanceConfigurationList[0].id).ResourceGroupName
        Write-Output "Retrieving List of VM's for $ResourceGroupName to update"
        $VMList = Get-AzVM -ResourceGroupName $ResourceGroupName
    
        ForEach ($VM in $VMList) {
            # Starting VM if it is shutdown
            $VMName = $VM.Name
            $VMTurnedOn = $False
            If ((Get-AzVM -VMName $VMName -Status).PowerState -eq "VM deallocated") {
                Write-Output "Starting $VMName"
                Start-AzVM -Name $VMName -ResourceGroupName $ResourceGroupName | Out-Null
                $VMTurnedOn = $True
            }
            Write-Output "Installing Updates on $VMName in $ResourceGroupName with reboot $RebootSetting"
            $PatchesInstalled = Invoke-AzVmInstallPatch -resourcegroup $vm.ResourceGroupName -VmName $VM.Name -Windows -ClassificationToIncludeForWindows Critical,Security -RebootSetting $RebootSetting -MaximumDuration PT2H
            IF ($VMTurnedOn) {
                Write-Output "Stopping $VMName"
                Stop-AzVM -Name $VMName -ResourceGroupName $ResourceGroupName -Force | Out-Null
            }
            Write-Output ""
            Write-Output "Installed the following Patches on $VMName"
            ForEach ($Patch in $PatchesInstalled.Patches) {
                Write-OutPut $Patch.Name
            }
        }
    } Else {
       Write-OutPut "Script started outside the patch window $PatchDatetime (+15min)"
    }
}
