// Day 1 Lab 2 — Architecture validation only; DO NOT DEPLOY without cost approval.
targetScope = 'resourceGroup'

@description('Azure region for the virtual network')
param location string = resourceGroup().location

@description('Lab VNet name')
param vnetName string = 'vnet-reference-lab-dev'

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet-appservice-integration'
        properties: {
          addressPrefix: '10.20.1.0/26'
          delegations: [
            {
              name: 'appservice-delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
      {
        name: 'snet-private-endpoints'
        properties: {
          addressPrefix: '10.20.2.0/27'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

resource blobPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.blob.${environment().suffixes.storage}'
  location: 'global'
}

resource blobDnsVnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: blobPrivateDnsZone
  name: 'link-reference-lab-vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

output vnetId string = vnet.id
output blobPrivateDnsZoneName string = blobPrivateDnsZone.name
