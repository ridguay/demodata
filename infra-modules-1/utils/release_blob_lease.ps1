# Set variables    
$storageAccountName = "stlpdapv001metatfstate"  
$storageAccountKey = $env:StorageAccountKey  
  
# Connect to Azure Storage    
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey  
  
# Validate the command line arguments    
$validArgs = "dev", "tst", "prd", "acc"  
foreach ($arg in $args) {  
    if (-not $validArgs.Contains($arg)) {  
        Write-Error "Invalid argument: $arg. Valid arguments are: $validArgs"  
        Exit 1  
    }  
}  
  
# Release the lease on all blobs in the chosen containers    
foreach ($containerName in $args) {    
    Write-Host "Releasing leases in container $containerName..."  
  

    $blobs = Get-AzStorageBlob -Context $storageContext -Container $containerName
    $blob.ICloudBlob.Properties.LeaseState
    foreach ($blob in $blobs) {    
        if ($blob.BlobProperties.LeaseState  -eq "Leased") {    
            $blob.ICloudBlob.BreakLease()
            Write-Host "Lease released on blob $($blob.Name) in container $containerName."    
        }    
    }    
}  
  
Write-Host "All leases released successfully."   