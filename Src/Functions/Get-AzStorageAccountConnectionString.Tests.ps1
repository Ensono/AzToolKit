$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"


# // START test setup //

$testStorageAccountName = "testAccountName"
$testPrimaryKey = "TestPrimaryKey"
$testSecondaryKey = "TestSecondaryKey"

$testExceptionMessage = ("There was an issue connecting to the Storage Account {0}" -f $testStorageAccountName)
$testAzureResponse = @{"Primary" = $testPrimaryKey; "Secondary" = $testSecondaryKey}

$testConnectionString = "DefaultEndpointsProtocol=https;AccountName={0};AccountKey={1}"

# // END test setup //


Describe "Get-AzStorageAccountConnectionString" {
    
    Mock -CommandName Write-Host
    Mock -CommandName Get-AzureStorageKey -MockWith {return $testAzureResponse}

    Context "Empty Azure response returned" {

        Mock -CommandName Get-AzureStorageKey
        
        It ("should throw an exception with message '{0}'" -f $testExceptionMessage) {
                
            {Get-AzStorageAccountConnectionString -targetName $testStorageAccountName} | Should throw $testExceptionMessage

            Assert-MockCalled -CommandName Get-AzureStorageKey -Times 1 -Exactly
                
        }
    }

    Context "Fully qualified storage account connection string returned" {      
        
        It "should return with Primary key" {

            $testResult = Get-AzStorageAccountConnectionString -targetName $testStorageAccountName
            $testResult | Should be ($testConnectionString -f $testStorageAccountName, $testPrimaryKey)
            
            Assert-MockCalled -CommandName Get-AzureStorageKey -Times 1 -Exactly -Scope It        
                
        }

        It "should return with Secondary key" {

            $testResult = Get-AzStorageAccountConnectionString -targetName $testStorageAccountName -keyType Secondary
            $testResult | Should be ($testConnectionString -f $testStorageAccountName, $testSecondaryKey)
            
            Assert-MockCalled -CommandName Get-AzureStorageKey -Times 1 -Exactly -Scope It          
                
        }
    }
}
