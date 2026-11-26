// Day 2 Lab 4 — local-only Canadian policy initiative exercise.
// Creates THREE custom AUDIT definitions and TWO initiatives, but NO assignments.
// Do NOT deploy without explicit governance review and approval.
targetScope = 'subscription'

@description('Approved lab locations; customer-specific. Include global only after service review.')
param allowedLocations array = [
  'canadacentral'
  'canadaeast'
  'global'
]

@description('Illustrative non-production VM sizes, not an approved production catalog.')
param allowedDevVmSizes array = [
  'Standard_B2s'
  'Standard_D2s_v5'
]

resource locationAudit 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'reference-audit-allowed-locations'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'reference lab - Audit resources outside approved locations'
    description: 'Training definition only; approved regions fixed at template deployment time.'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'location'
            exists: 'true'
          }
          {
            field: 'location'
            notIn: allowedLocations
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

resource environmentTagAudit 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'reference-audit-environment-tag'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'reference lab - Audit missing Environment tag'
    description: 'Training definition; resource applicability and tag exceptions require review.'
    policyRule: {
      if: {
        field: 'tags[Environment]'
        exists: 'false'
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

resource devVmSizeAudit 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'reference-audit-dev-vm-sizes'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'reference lab - Audit non-approved VM sizes'
    description: 'Training definition intended for non-production assignment only.'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachines'
          }
          {
            field: 'Microsoft.Compute/virtualMachines/hardwareProfile.vmSize'
            notIn: allowedDevVmSizes
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

// Baseline for a customer scope: geography and supported tagging.
resource customerBaseline 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'reference-canada-customer-baseline'
  properties: {
    policyType: 'Custom'
    displayName: 'reference lab - Canadian customer baseline'
    description: 'Locations and Environment tag, audit only; not assigned.'
    policyDefinitions: [
      {
        policyDefinitionId: locationAudit.id
        policyDefinitionReferenceId: 'locations'
      }
      {
        policyDefinitionId: environmentTagAudit.id
        policyDefinitionReferenceId: 'environmentTag'
      }
    ]
  }
}

// Extended baseline for non-production ONLY: adds VM size checks.
resource nonProductionBaseline 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'reference-canada-nonprod-baseline'
  properties: {
    policyType: 'Custom'
    displayName: 'reference lab - Canadian non-production baseline'
    description: 'Locations, Environment tag and illustrative VM sizes; not assigned.'
    policyDefinitions: [
      {
        policyDefinitionId: locationAudit.id
        policyDefinitionReferenceId: 'locations'
      }
      {
        policyDefinitionId: environmentTagAudit.id
        policyDefinitionReferenceId: 'environmentTag'
      }
      {
        policyDefinitionId: devVmSizeAudit.id
        policyDefinitionReferenceId: 'vmSize'
      }
    ]
  }
}

output customerBaselineId string = customerBaseline.id
output nonProductionBaselineId string = nonProductionBaseline.id
