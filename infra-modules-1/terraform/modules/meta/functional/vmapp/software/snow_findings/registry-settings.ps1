<#
.SYNOPSIS
    This Azure VM script fixes several ServiceNow findings op the VM's

.DESCRIPTION

   This Azure VM script applies the registry changes in the filename to the VM

   csv format

Description;Reason;Path;Key;Value;Type
EnableCertPaddingCheck;TEN-166555: The remote system may be in a vulnerable state to CVE-2013-3900 due to a missing or misconfigured registry keys;HKLM:\Software\Microsoft\Cryptography\Wintrust\Config;EnableCertPaddingCheck;1;String
EnableCertPaddingCheck;TEN-166555: The remote system may be in a vulnerable state to CVE-2013-3900 due to a missing or misconfigured registry keys;HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config;EnableCertPaddingCheck;1;String

   It also fixes a libcurl vulnerability. This done by the Update_LibCurl function

   - Creates a backup of libcurl versions installed by the Microsoft Intergration Runtime Software
   - Downloads an updated Libcurl package from a storage account
   - Replaces the vulnerable libcurl.dll files with a newer version.


.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>

Function Check-Finding {

    Param (
        $Description,
        $Reason,
        $Path,
        $Key,
        $Value,
        $Type
    )

    Write-Host "$Description ($Reason) : " -NoNewline

    If ((Get-ItemProperty -Path $Path -ErrorAction SilentlyContinue).$key -eq $Null) {
        Write-Host "Null" -ForegroundColor red

    } Else { 
        If ((Get-ItemProperty -Path $Path -ErrorAction SilentlyContinue).$key -eq $Value) {
            Write-Host (Get-ItemProperty -Path $Path -ErrorAction SilentlyContinue).$key -ForegroundColor Green
        } Else {

            Write-Host (Get-ItemProperty -Path $Path -ErrorAction SilentlyContinue).$key  -ForegroundColor Red
        }
    }

}


Function Fix-Finding {

    Param (
        $Description,
        $Reason,
        $Path,
        $Key,
        $Value,
        $Type
    )

    If ((Get-Item -Path $Path -ErrorAction SilentlyContinue) -eq $Null) {
        Write-Host "Create $Path"
        New-Item -Path $Path -Force -ErrorAction SilentlyContinue | Out-Null
    }

    If ((Get-ItemProperty -Path $Path -name $Key -ErrorAction SilentlyContinue) -eq $Null) {
        Write-Host "Create $Path\$Key with $Value"
        New-ItemProperty -Path $Path -Name $key -Value $Value -PropertyType $Type -ErrorAction Stop | Out-Null
    } Else {
        Write-Host "$Path\$Key Set to $Value"
        Set-ItemProperty -Path $Path -Name $key -Value $Value | Out-Null
    }

}

Function Backup_Folder { 

    Param (
        $FolderName,
        $BackupZipName
    )

    $BackupFolder = "C:\Backup"

    If ( -not (Test-Path -Path $BackupFolder)) {
        Write-Host "Creating $backupfolder"
        $result = New-Item -Path $backupfolder -ItemType Directory
    }

    Get-ChildItem -Path $FolderName | Compress-Archive -DestinationPath "$BackupFolder\$BackupZipName"

}

Function Download_File {

    Param (
        $Filename,
        $Container,
        $StorageAccount
    )


    $TempFolder = "C:\Temp"

    If ( -not (Test-Path -Path $TempFolder)) {
        Write-Host "Creating $Tempfolder"
        $result = New-Item -Path $Tempfolder -ItemType Directory
    }

    Invoke-WebRequest -Uri "https://$StorageAccount.blob.core.windows.net/$Container/$Filename" -OutFile "$TempFolder\$FileName"

}

Function Replace_File {

    Param (
        $ArchiveFilename,
        $SourceFileToReplace,
        $DestinationFileToReplace,
        $DestinationFolder
    )

    Expand-Archive -Path "C:\temp\$ArchiveFilename" -DestinationPath c:\temp -Force
    
    $SourceFilePath = Get-ChildItem -Path "C:\temp\" -Include $SourceFileToReplace -Recurse

    $ReplaceFileList = Get-ChildItem -Path $DestinationFolder -Include $DestinationFileToReplace -File -Recurse

    $SourceVersionInfo = (Get-Item $SourceFilePath.FullName).VersionInfo.FileVersionRaw


    ForEach ($DestinationFile in $ReplaceFileList) {

        $DestinationVersionInfo = (Get-Item $DestinationFile.FullName).VersionInfo.FileVersionRaw

        Copy-Item -Path $SourceFilePath.FullName -Destination $DestinationFile.FullName -Force

        Write-Host "$DestinationFile " -NoNewline
        Write-Host $DestinationVersionInfo.Major -NoNewline
        Write-Host "." -NoNewline
        Write-Host $DestinationVersionInfo.Minor -NoNewline
        Write-Host " New Version " -NoNewline
        Write-Host $SourceVersionInfo.Major -NoNewline
        Write-Host "." -NoNewline
        Write-Host $SourceVersionInfo.Minor
    }
}

Function Update_LibCurl {

    $DestinationFolder        = "C:\Program Files\Microsoft Integration Runtime\5.0\Shared\ODBC Drivers"
    $BackupZipName            = "IR_ODBC_Drivers_$(get-date -f dd-MM-yyyy-hhmm)"
    $StorageAccount           = "stlpdapv001metautils"
    $StorageContainer         = "drivers"
    $StorageFileName          = "libcurl.zip"
    $SourceFileToReplace      = "libcurl-x64.dll"
    $DestinationFileToReplace = "libcurl.dll"
    
    # Not needed to make a backup anymore, but line needs to stay for easy reverting of this change.
    # Backup_Folder -FolderName $DestinationFolder -BackupZipName $BackupZipName

    Download_file -StorageAccount $StorageAccount -Container $StorageContainer -Filename $StorageFileName

    Replace_File -ArchiveFilename $StorageFileName -SourceFileToReplace $SourceFileToReplace -DestinationFileToReplace $DestinationFileToReplace -DestinationFolder $DestinationFolder

}

# SNow Findings fixes in the Windows registry.

$Filename = "c:\Packages\snow_findings\snow-findings.csv"

$FindingsList = Import-Csv -Delimiter ";" -Path $filename

ForEach ($Finding in $FindingsList) {

    Check-Finding -Description $Finding.Description -Reason $Finding.Reason -Path $Finding.Path -Key $Finding.Key -Value $Finding.Value

    Fix-Finding -Description $Finding.Description -Reason $Finding.Reason -Path $Finding.Path -Key $Finding.Key -Value $Finding.Value -Type $Finding.Type

}

# Fix for Libcurl.dll used by the drivers in the Microsoft Shared Integration Runtime.

Update_LibCurl
