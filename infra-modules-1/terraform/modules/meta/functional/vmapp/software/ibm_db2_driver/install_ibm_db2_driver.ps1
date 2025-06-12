<#
.SYNOPSIS
	This Powershell script installs IBM DB2 driver on the Shared Intergration Runtime VM's

.DESCRIPTION
	This Powershell script installs IBM DB2 driver on the Shared Intergration Runtime VM's
    
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



function Install-IBM-DB2-Driver([string] $ibmPath) {
    if ( [string]::IsNullOrEmpty($ibmPath)) {
        Throw-Error "IBM DB2 Driver package path is not specified"
    }

    if (!(Test-Path -Path $ibmPath)) {
        Throw-Error "Invalid IBM DB2 Driver path: $ibmPath"
    }

    Trace-Log "Start IBM DB2 Driver installation"
    # Install driver command
    Run-Process "$ibmPath\clidriver\bin\db2oreg1" '-i'
    Run-Process "$ibmPath\clidriver\bin\db2oreg1" '-setup'


    # Now two registry keys need to be updated/Renamed.

    Rename-Item -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\IBM DATA SERVER DRIVER for ODBC - C:/Packages/ibm_db2_driver/clidriver" -NewName "DB2" -ErrorAction SilentlyContinue

    Rename-ItemProperty -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers" -Name "IBM DATA SERVER DRIVER for ODBC - C:/Packages/ibm_db2_driver/clidriver" -NewName "DB2" -ErrorAction SilentlyContinue
   

}

function UnInstall-IBM-DB2-Driver([string] $ibmPath) {
    if ( [string]::IsNullOrEmpty($ibmPath)) {
        Throw-Error "IBM DB2 Driver package path is not specified"
    }

    if (!(Test-Path -Path $ibmPath)) {
        Throw-Error "Invalid IBM DB2 Driver path: $ibmPath"
    }

    Trace-Log "Start IBM DB2 Driver uninstall"
    Remove-Item -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\DB2"
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers"-Name "DB2"
}

$Package_Folder = "C:\Packages\ibm_db2_driver"
$StorageFilename = "v11.5.5fp1_ntx64_odbc_cli.zip"

Invoke-WebRequest -uri "https://stlpdapv001metautils.blob.core.windows.net/drivers/$StorageFilename" -OutFile "$Package_Folder\$StorageFilename"

Expand-Archive "$Package_Folder\$StorageFilename" -DestinationPath $Package_Folder

Install-IBM-DB2-Driver -ibmPath $Package_Folder



