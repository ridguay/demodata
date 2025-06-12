<#
.SYNOPSIS
	This Powershell script installs/upgrades the Integration Runtime on the Shared Intergration Runtime VM's

.DESCRIPTION
	This Powershell script installs/upgrades the Integration Runtime on the Shared Intergration Runtime VM's
 
    
.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>

function Throw-Error([string] $msg) {
    try {
        throw $msg
    }
    catch {
        $stack = $_.ScriptStackTrace
        Trace-Log "Installation is failed: $msg`nStack:`n$stack"
    }
    throw $msg
}


function Trace-Log([string] $msg) {
    $now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    try {
        "$now $msg`n" | Tee-Object -FilePath $logPath -Append | Write-Host
    }
    catch {
        # Ignore any exception during trace
    }
}


function Run-Process([string] $process, [string] $arguments) {
    Write-Verbose "Run-Process: $process $arguments"

    $errorFile = "$env:tmp\tmp$pid.err"
    $outFile = "$env:tmp\tmp$pid.out"
    "" | Out-File $outFile
    "" | Out-File $errorFile

    $errVariable = ""

    if ( [string]::IsNullOrEmpty($arguments)) {
        $proc = Start-Process -FilePath $process -Wait -Passthru -NoNewWindow `
            -RedirectStandardError $errorFile -RedirectStandardOutput $outFile -ErrorVariable errVariable
    }
    else {
        $proc = Start-Process -FilePath $process -ArgumentList $arguments -Wait -Passthru -NoNewWindow `
            -RedirectStandardError $errorFile -RedirectStandardOutput $outFile -ErrorVariable errVariable
    }

    $errContent = [string](Get-Content -Path $errorFile -Delimiter "!!!DoesNotExist!!!")
    $outContent = [string](Get-Content -Path $outFile -Delimiter "!!!DoesNotExist!!!")

    Remove-Item $errorFile
    Remove-Item $outFile

    if ($proc.ExitCode -ne 0 -or $errVariable -ne "") {
        Throw-Error "Failed to run process: exitCode=$( $proc.ExitCode ), errVariable=$errVariable, errContent=$errContent, outContent=$outContent."
    }

    Trace-Log "Run-Process: ExitCode=$( $proc.ExitCode ), output=$outContent"

    if ( [string]::IsNullOrEmpty($outContent)) {
        return $outContent
    }

    return $outContent.Trim()
}



function Install-IR([string] $irPath) {
    if ( [string]::IsNullOrEmpty($irPath)) {
        Throw-Error "JRE package path is not specified"
    }

    if (!(Test-Path -Path $irPath)) {
        Throw-Error "Invalid JRE path: $irPath"
    }

    $msipath = $irPath + "integrationruntime.msi"


    Trace-Log "Start Integration Runtime installation"
    Run-Process "msiexec.exe" "/i $msipath /quiet /qn /norestart"
    Trace-Log "Installation/Upgrade of Integration RUntime is successful"


}



$Package_Folder = "C:\Packages\integration_runtime\"
$StorageFilename = "integration_runtime.zip"

Invoke-WebRequest -uri "https://stlpdapv001metautils.blob.core.windows.net/drivers/$StorageFilename" -OutFile "$Package_Folder\$StorageFilename"

Get-ChildItem -Path $Package_Folder -Name *.msi | Remove-Item -Force

Expand-Archive "$Package_Folder\$StorageFilename" -DestinationPath $Package_Folder

# Rename the installation file to the correct name

Get-ChildItem -Path $Package_Folder | Where-Object { $_.Name -Like "IntegrationRuntime*" } | %{Rename-Item -Path $Package_Folder$_ -Newname "integrationruntime.msi"}

# Only run upgrade installation if integration runtime has been installed and configured.
if ((Get-Process "diahost" -ea SilentlyContinue) -ne $Null)
{
    Install-IR -irPath $Package_Folder
}

# Run script to fix Libcurl vulnerability again after installation of the Integration runtime, because that could install vulnerable libaries again.

$LibCurlScript = "C:\Packages\snow_findings\registry-settings.ps1"

if (Test-Path -Path $LibCurlScript) {
    & $LibCurlScript
}