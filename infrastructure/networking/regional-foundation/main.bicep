// reference reference - Canada network foundation v2
// Resource-group scope. No App Service, private endpoint, PaaS, or billable gateway.
// Compile locally; DO NOT deploy without explicit approval.
targetScope = 'resourceGroup'

@description('Region for the network resources; must match the chosen resource location.')
@allowed([
  'canadacentral'
  'canadaeast'
  'eastus2'
])
param location string = 'canadacentral'

@description('VNet name for this isolated development lab.')
param vnetName string = 'vnet-reference-canadacentral-dev'

@description('VNet address space; verify it will not overlap future connected networks.')
param vnetPrefix string = '10.20.0.0/16'

@description('Delegated App Service outbound VNet Integration subnet.')
param appIntegrationPrefix string = '10.20.1.0/26'

@description('Reserved subnet for future PaaS private endpoint NICs.')
param privateEndpointPrefix string = '10.20.2.0/27'

@description('Resource ownership and purpose tags.')
param tags object = {
  Environment: 'Dev'
  Project: 'DigitalPlatformReference'
  ManagedBy: 'Bicep'
  Purpose: 'Learning'
}

resource appIntegrationNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'nsg-reference-app-integration-dev'
  location: location
  tags: tags
  properties: {
    securityRules: []
  }
}

resource privateEndpointsNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'nsg-reference-private-endpoints-dev'
  location: location
  tags: tags
  properties: {
    securityRules: []
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [vnetPrefix]
    }
    subnets: [
      {
        name: 'snet-appservice-integration'
        properties: {
          addressPrefix: appIntegrationPrefix
          delegations: [
            {
              name: 'appservice-delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
          networkSecurityGroup: {
            id: appIntegrationNsg.id
          }
        }
      }
      {
        name: 'snet-private-endpoints'
        properties: {
          addressPrefix: privateEndpointPrefix
          // Enables subnet network policies for future private endpoints.
          // This does NOT automatically create secure custom NSG rules.
          privateEndpointNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: privateEndpointsNsg.id
          }
        }
      }
    ]
  }
}

output networkName string = vnet.name
output networkLocation string = location
output networkResourceId string = vnet.id
output designedSubnets array = [
  'snet-appservice-integration: ${appIntegrationPrefix}'
  'snet-private-endpoints: ${privateEndpointPrefix}'
]
