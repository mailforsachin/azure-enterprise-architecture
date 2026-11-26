// Day 2 — reusable customer-scoped policy definition.
// SAFE LAB: compile locally only. Do not deploy without governance approval.
targetScope = 'subscription'

@description('Unique name for this customer-specific policy definition.')
param policyName string = 'audit-allowed-locations-canada-reference'

@description('Approved Azure resource locations. The global entry accommodates global-scope services where appropriate.')
param approvedLocations array = [
  'canadacentral'
  'canadaeast'
  'global'
]

resource allowedLocationsPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Audit resources outside approved customer locations'
    description: 'Lab-only regional audit policy. Customer-specific scope and exclusions require review.'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'location'
            exists: 'true'
          }
          {
            field: 'location'
            notIn: approvedLocations
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

output policyDefinitionId string = allowedLocationsPolicy.id
