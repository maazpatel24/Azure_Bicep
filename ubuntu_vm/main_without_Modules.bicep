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
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-04-01' = {
  name: storageAccountName
  location: rglocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Resource_Owner: 'Maaz Patel'
    Delivery_Manager: 'Shriram Deshpande'
    Sub_Business_Unit: 'PES-IA'
    Business_Unit: 'Einfochips'
    Project_Name: 'Training and learning'
    Create_Date: '21 May 2024'
  }
}


// Creating PublicIP
resource publicIP 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: 'bicep_PublicIP'
  location: rglocation
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: 'dnsname'
    }
  }
  tags: {
    Resource_Owner: 'Maaz Patel'
    Delivery_Manager: 'Shriram Deshpande'
    Sub_Business_Unit: 'PES-IA'
    Business_Unit: 'Einfochips'
    Project_Name: 'Training and learning'
    Create_Date: '21 May 2024'
  }
}


// Creating VirtualNetwork
resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'bicep_VNET'
  location: rglocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
  tags: {
    Resource_Owner: 'Maaz Patel'
    Delivery_Manager: 'Shriram Deshpande'
    Sub_Business_Unit: 'PES-IA'
    Business_Unit: 'Einfochips'
    Project_Name: 'Training and learning'
    Create_Date: '21 May 2024'
  }
}

// Creating NetworkInterface
resource nic 'Microsoft.Network/networkInterfaces@2023-11-01' = {
  name: 'bicep_NIC'
  location: rglocation
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
          }
          subnet: {
            id: vnet.properties.subnets[0].id
          }
        }
      }
    ]
  }
  tags: {
    Resource_Owner: 'Maaz Patel'
    Delivery_Manager: 'Shriram Deshpande'
    Sub_Business_Unit: 'PES-IA'
    Business_Unit: 'Einfochips'
    Project_Name: 'Training and learning'
    Create_Date: '21 May 2024'
  }
}

// Creating VirtualMachine
resource ubuntuVM 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: 'bicep_VM'
  location: rglocation
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: 'computerName'
      adminUsername: adminUsername
      adminPassword: adminPassword // '$amp1ePa55word'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        name: 'osDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: storageAccount.properties.primaryEndpoints.blob
      }
    }
  }
  tags: {
    Resource_Owner: 'Maaz Patel'
    Delivery_Manager: 'Shriram Deshpande'
    Sub_Business_Unit: 'PES-IA'
    Business_Unit: 'Einfochips'
    Project_Name: 'Training and learning'
    Create_Date: '21 May 2024'
  }
}

// output names string = publicIP.properties.dnsSettings.fqdn


