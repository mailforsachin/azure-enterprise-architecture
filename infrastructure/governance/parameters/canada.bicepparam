using '../policy-definition.bicep'

param policyName = 'audit-allowed-locations-canada-reference'
param approvedLocations = [
  'canadacentral'
  'canadaeast'
  'global'
]
