targetScope = 'resourceGroup'

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Environment name')
param environment string = 'dev'

var storageName = 'dplat${uniqueString(resourceGroup().id)}'

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: {
    Environment: environment
    Project: 'DigitalPlatformReference'
    Purpose: 'Training'
  }
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
  }
}

output storageAccountName string = storage.name
output storageAccountId string = storage.id
