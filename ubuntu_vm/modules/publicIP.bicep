param location string


resource publicIP 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: 'bicep_PublicIP'
  location: location
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

output publicIPid string = publicIP.id
