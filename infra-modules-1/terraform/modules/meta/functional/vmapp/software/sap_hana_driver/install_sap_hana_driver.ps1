<#
.SYNOPSIS
	This Powershell script installs SAP Hana driver on the Shared Intergration Runtime VM's

.DESCRIPTION
	This Powershell script installs SAP Hana driver on the Shared Intergration Runtime VM's
    
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



function Install-SAP-Hana-Driver([string] $sapPath) {
    if ( [string]::IsNullOrEmpty($sapPath)) {
        Throw-Error "SAP Hana Driver package path is not specified"
    }

    if (!(Test-Path -Path $sapPath)) {
        Throw-Error "Invalid SAP Hana Driver path: $sapPath"
    }

    Trace-Log "Start SAP Hana Driver installation"
    Run-Process "$sapPath\hdbinst" '--batch --path="C:\Program Files\sap\hdbclient"'


}

function UnInstall-SAP-Hana-Driver([string] $sapPath) {
    if ( [string]::IsNullOrEmpty($sapPath)) {
        Throw-Error "SAP Hana Driver package path is not specified"
    }

    if (!(Test-Path -Path $sapPath)) {
        Throw-Error "Invalid JRE path: $sapPath"
    }

    Trace-Log "Start SAP Hana Driver uninstall"
    Run-Process "$sapPath\hdbuninst" '--batch --path="C:\Program Files\sap\hdbclient"'

    Start-Sleep -Seconds 15

}

$Package_Folder = "C:\Packages\sap_hana_driver"
$StorageFilename = "HanaClient-2.13.22-windows-x64.zip"

Invoke-WebRequest -uri "https://stlpdapv001metautils.blob.core.windows.net/drivers/$StorageFilename" -OutFile "$Package_Folder\$StorageFilename"

Expand-Archive "$Package_Folder\$StorageFilename" -DestinationPath $Package_Folder

Install-SAP-Hana-Driver -sapPath $Package_Folder



