// Day 2 — separate assignment to a pre-existing definition.
// SAFE LAB: compile locally only. This template does not create the definition.
targetScope = 'subscription'

@description('Name of the policy definition already created in the SAME subscription.')
param policyName string = 'audit-allowed-locations-canada-reference'

@description('Unique name for the policy assignment.')
param assignmentName string = 'assign-audit-locations-canada-reference'

resource existingPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' existing = {
  name: policyName
}

resource auditAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: assignmentName
  properties: {
    displayName: 'Canada reference: location audit (non-enforcing)'
    description: 'Lab design only. No live assignment authorized.'
    policyDefinitionId: existingPolicy.id
    enforcementMode: 'DoNotEnforce'
  }
}

output policyAssignmentId string = auditAssignment.id
