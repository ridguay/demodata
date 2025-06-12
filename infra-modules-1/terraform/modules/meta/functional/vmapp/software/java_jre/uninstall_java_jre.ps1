<#
.SYNOPSIS
	This Powershell script uninstalls Java JRE on the Shared Intergration Runtime VM's

.DESCRIPTION
	This Powershell script uninstalls Java JRE on the Shared Intergration Runtime VM's

    Allmost all code was taken from the terraform\modules\core\data_factory\self_hosted_integration_runtime\virtual_machine\vm_custom_data.ps1 script.
    
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

function UnInstall-JRE([string] $jrePath) {
    if ( [string]::IsNullOrEmpty($jrePath)) {
        Throw-Error "JRE package path is not specified"
    }

    if (!(Test-Path -Path $jrePath)) {
        Throw-Error "Invalid JRE path: $jrePath"
    }

    $msipath = $jrepath + "jre.msi"

    Trace-Log "Start JRE uninstall"
    msiexec.exe /uninstall  $msipath /q
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', '', 'Machine')
    Start-Sleep -Seconds 15

}

$Package_Folder = "C:\Packages\java_jre\"

UnInstall-JRE -jrePath $Package_Folder



