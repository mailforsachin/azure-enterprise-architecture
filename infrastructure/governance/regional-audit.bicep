targetScope = 'subscription'

@description('Policy definition name')
param policyName string = 'audit-canada-regions-reference-lab'

resource locationPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Audit resources outside Canada'
    description: 'Audit resources outside approved Canadian regions.'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'location'
            exists: 'true'
          }
          {
            field: 'location'
            notIn: [
              'canadacentral'
              'canadaeast'
              'global'
            ]
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

output policyDefinitionId string = locationPolicy.id
