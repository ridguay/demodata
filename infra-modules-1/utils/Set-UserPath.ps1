<#
.SYNOPSIS
	This powershell script extends the user PATH environment variable with a folder you specify. 

.DESCRIPTION
	This powershell script extends the user PATH environment variable with a folder you specify. 

    Without admin rights on your computer you cannot access or set the environment variable PATH so it is remembered.

    Start the script from powershell, fill in the folder like C:\Bla without ;. 

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>


$Folder = Read-Host "Supply Folder to add to Path"

If ((Get-ItemProperty -Path HKCU:\Environment -Name "Path" -ErrorAction SilentlyContinue) -eq $Null) {

    
    New-ItemProperty -Path HKCU:\Environment -Name "Path" -Value $Folder | Out-Null

    

} Else {
    $CurrentPath = (Get-ItemProperty -Path HKCU:\Environment -Name "Path").Path
    $NewPath = "$CurrentPath;$Folder"
    Set-ItemProperty -Path HKCU:\Environment -Name "Path" -Value $NewPath | Out-Null
}

Write-Host "New User PATH=" -NoNewline
Write-Host (Get-ItemProperty -Path HKCU:\Environment -Name "Path").Path
Write-Host ""
Write-Host "Please close CMD.EXE/Powershell.exe/PWSH.exe to enable the new PATH settings" 