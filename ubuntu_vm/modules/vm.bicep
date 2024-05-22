param location string
param adminUsername string
@secure()
param adminPassword string
param networkInterfaceId string
param storageAccount_storageUri string

resource ubuntuVM 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: 'bicep_VM'
  location: location
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
          id: networkInterfaceId
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: storageAccount_storageUri
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
