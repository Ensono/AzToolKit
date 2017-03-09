Function Get-AzStorageAccountConnectionString {

    param (
        [Parameter(Mandatory=$true)]
        [string]$targetName,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("Primary","Secondary")]
        $keyType = "Primary"
    )

    
    Write-Host ("`nRunning function: {0}" -f $MyInvocation.MyCommand.Name) -ForegroundColor Yellow
    Write-Host ("KeyType: {0}" -f $keyType)
   
    
    # // getting storage account keys //
    $storageKeys = Get-AzureStorageKey -StorageAccountName $targetName -ErrorAction SilentlyContinue

    
    # // checking for a response //
    If (-not $storageKeys) {

        Throw "There was an issue connecting to the Storage Account {0}" -f $targetName
    }

    
    # // building connection string //
    $connectionString = "DefaultEndpointsProtocol=https;AccountName={0};AccountKey={1}" -f $targetName, $storageKeys.$keyType
    
    
    # // returing result //
    return $connectionString

}