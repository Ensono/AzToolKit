#### Build Status
Appveyor:  
[![Build status](https://ci.appveyor.com/api/projects/status/w1cnyy2ldfooje5t?svg=true)](https://ci.appveyor.com/project/amido/aztoolkit)

**AzToolkit** is published in the [Chocolatey packages community feed](https://chocolatey.org/packages/AzToolkit) and has a dependency on the [Azure Powershell module](https://github.com/Azure/azure-powershell).

As AzTookit is a PowerShell module it will autoload when any exported functions are invoked. The module will fail to load if the **Azure PowerShell** module is not included in the list of available PowerShell modules.

```PowerShell
Get-Module -listavailable
```

---
## AzToolkit
List of exported functions:
* Get-AzStorageAccountConnectionString


#### Get-AzStorageAccountConnectionString  
*targetName*  
Mandatory - The name of the storage account

*keyType*  
Optional - The type of key to return. Will default to **Primary**. Options are:
* Primary
* Secondary


###### Examples
```PowerShell
Get-AzStorageAccountConnectionString -targetName "aztkaccount01"
Get-AzStorageAccountConnectionString -targetName "aztkaccount01" -keyType Secondary
```
