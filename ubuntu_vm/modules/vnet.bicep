param location string

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'bicep_VNET'
  location: location
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

output subnetId string = vnet.properties.subnets[0].id
