param location string
param publicIPid string
param subnetId string

resource nic 'Microsoft.Network/networkInterfaces@2023-11-01' = {
  name: 'bicep_NIC'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPid
          }
          subnet: {
            id: subnetId
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

output networkInterfaceId string = nic.id
