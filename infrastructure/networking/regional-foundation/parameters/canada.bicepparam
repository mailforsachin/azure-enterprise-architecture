using '../main.bicep'

param location = 'canadacentral'
param vnetName = 'vnet-reference-canadacentral-dev'
param vnetPrefix = '10.20.0.0/16'
param appIntegrationPrefix = '10.20.1.0/26'
param privateEndpointPrefix = '10.20.2.0/27'
param tags = {
  Environment: 'Dev'
  Project: 'DigitalPlatformReference'
  ManagedBy: 'Bicep'
  Purpose: 'Learning'
}
