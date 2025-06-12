<#
.SYNOPSIS
	This Powershell script installs/configures the Integration Runtime on the Shared Intergration Runtime VM's

.DESCRIPTION
	This Powershell script installs/configures the Integration Runtime on the Shared Intergration Runtime VM's

    This script is now hosted on a storage account and was uploaded there manually.
 
    
.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>

param(
    [string]$authKey,
    [string]$dfHost,
    [string]$dfIP
)

function Append-EntryInHostFile($ip, $fqdn) {
    Trace-Log "Appending new entry to host file..."
    Add-Content -Encoding UTF8  C:\Windows\system32\drivers\etc\hosts "$ip $fqdn"
}

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

function Install-Gateway([string] $gatewayPath) {
    if ( [string]::IsNullOrEmpty($gatewayPath)) {
        Throw-Error "Gateway path is not specified"
    }

    if (!(Test-Path -Path $gatewayPath)) {
        Throw-Error "Invalid gateway path: $gatewayPath"
    }

    Trace-Log "Start Gateway installation"
    Run-Process "msiexec.exe" "/i $gatewayPath INSTALLTYPE=AzureTemplate /quiet /norestart"

    Start-Sleep -Seconds 30

    Trace-Log "Installation of gateway is successful"
}

function Get-RegistryProperty([string] $keyPath, [string] $property) {
    Trace-Log "Get-RegistryProperty: Get $property from $keyPath"
    if (!(Test-Path $keyPath)) {
        Trace-Log "Get-RegistryProperty: $keyPath does not exist"
    }

    $keyReg = Get-Item $keyPath
    if (!($keyReg.Property -contains $property)) {
        Trace-Log "Get-RegistryProperty: $property does not exist"
        return ""
    }

    return $keyReg.GetValue($property)
}

function Get-InstalledFilePath() {
    $filePath = Get-RegistryProperty "hklm:\Software\Microsoft\DataTransfer\DataManagementGateway\ConfigurationManager" "DiacmdPath"
    if ( [string]::IsNullOrEmpty($filePath)) {
        Throw-Error "Get-InstalledFilePath: Cannot find installed File Path"
    }
    Trace-Log "Gateway installation file: $filePath"

    return $filePath
}

function Register-Gateway([string] $instanceKey) {
    Trace-Log "Register Agent"
    $filePath = Get-InstalledFilePath
    Run-Process $filePath "-era 8060"
    Run-Process $filePath "-Key $instanceKey"
    Trace-Log "Agent registration is successful!"
}

# init log setting
$logLoc = "$env:SystemDrive\WindowsAzure\Logs\Plugins\Microsoft.Compute.CustomScriptExtension\"
if (!(Test-Path($logLoc))) {
    New-Item -path $logLoc -type directory -Force
}
$logPath = "$logLoc\tracelog.log"
"Start to excute gatewayInstall.ps1. `n" | Out-File $logPath

Trace-Log "Log file: $logLoc"

Trace-Log "Adding FDQN to host file..."
Append-EntryInHostFile -fqdn $dfHost -ip $dfIP

Expand-Archive "integration_runtime.zip" -DestinationPath "." -Force
Get-ChildItem -Path $Package_Folder | Where-Object { $_.Name -Like "IntegrationRuntime*" } | %{Rename-Item -Path $Package_Folder$_ -Newname "integrationruntime.msi"}

$gatewayPath = Join-Path -Path (Get-Location).Path -ChildPath "integrationruntime.msi"
Trace-Log "Gateway download location: $gatewayPath"

if ((Get-Process "diahost" -ea SilentlyContinue) -eq $Null)
{
	Trace-Log "Installing Gateway..."
	Install-Gateway $gatewayPath
	Trace-Log "Registering Gateway..."
	Register-Gateway $authKey
}
else
{
	Trace-Log "Integration Runtime is already running. Skipping installation & configuration."
}