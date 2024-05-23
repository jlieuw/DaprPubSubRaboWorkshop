/*
 * Module:
 * Deploy a VNET and subnet(s) 
 *
 * Description:
 * This module deploys a VNET and if specified the subnets
 *
 * More information:
 * https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks?tabs=bicep
 */

 @description('Settings for the vnet')
 param addressPrefix string

 @description('Name of the VNET')
 param vnetName string
 
 @description('Location for all resources')
 param location string = resourceGroup().location
 
 
 resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
   name: vnetName
   location: location
   properties: {
     addressSpace: {
       addressPrefixes: [
         addressPrefix
       ]
     }
     subnets: [{
       name: 'snet-app'
       properties: {
        addressPrefix: '10.0.0.0/23'
         networkSecurityGroup: null 
         privateEndpointNetworkPolicies: 'Enabled'
         privateLinkServiceNetworkPolicies: 'Enabled'
         delegations: [
        ]
       }
     }]
     dhcpOptions: null
   }
 }
 

 output vnetId string = virtualNetwork.id 
 output appSubnetName string = virtualNetwork.properties.subnets[0].name
 output appSubnetId string = virtualNetwork.properties.subnets[0].id
 
 