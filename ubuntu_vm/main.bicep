// az deployment group create --resource-group sa1_test_eic_MaazPatel --template-file ./ubuntu_vm/main.bicep

@description('Username for the Virtual Machine.')
param adminUsername string

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string
param rglocation string = resourceGroup().location

// param storageAccountName string = 'bicep${uniqueString(resourceGroup().id)}'
var storageAccountName = 'bicep${uniqueString(resourceGroup().id)}'


// Creating Storage Account
module StorageAccount './modules/sa.bicep' = {
  name: storageAccountName
  params: {
    location: rglocation
  }
}

// Creating PublicIP
module PublicIP './modules/publicIP.bicep' = {
  name: 'bicep_PublicIP'
  params: {
    location: rglocation
  }
}

// Creating VirtualNetwork
module vnet './modules/vnet.bicep' = {
  name: 'bicep_VNET'
  params: {
    location: rglocation
  }
}

// Creating NetworkInterface
module NIC './modules/nic.bicep' = {
  name: 'bicep_NIC'
  params: {
    location: rglocation
    publicIPid: PublicIP.outputs.publicIPid
    subnetId: vnet.outputs.subnetId
  }
}

// Creating VirtualMachine
module VM './modules/vm.bicep' = {
  name: 'try_VM'
  params: {
    location: rglocation
    adminUsername: adminUsername
    adminPassword: adminPassword
    networkInterfaceId: NIC.outputs.networkInterfaceId
    storageAccount_storageUri: StorageAccount.outputs.storageURI
  }
}


// output names string = publicIP.properties.dnsSettings.fqdn


