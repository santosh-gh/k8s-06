using 'main.bicep'

param projectName =  'onlinestore'
param environment =  'dev'
param location = 'uksouth'
param resourceInstance = '001'

// Network
param vnetAddressPrefix = '10.0.0.0/16'
param subnets = [
  {
    name: 'privateEndpoints'
    addressPrefix: '10.0.0.0/24'
  }
  {
    name: 'snet-agents'
    addressPrefix: '10.0.1.0/24'
  }
]
