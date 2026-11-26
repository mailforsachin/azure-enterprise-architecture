using '../customer-baselines.bicep'

param allowedLocations = [
  'canadacentral'
  'canadaeast'
  'global'
]

// Sample sizes for local learning only. Not a validated regional SKU catalog.
param allowedDevVmSizes = [
  'Standard_B2s'
  'Standard_D2s_v5'
]
