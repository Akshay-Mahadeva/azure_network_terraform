# provider "azurerm" {
#   # alias = "remote-sub"
#   # subscription_id = var.subscription_remote
#   # client_id       = var.client_id_remote
#   # client_secret   = var.client_secret_remote
#   # tenant_id       = var.tenant_id_remote
#   features {

#   }

# }

data "azurerm_virtual_network" "primary" {
  name                = var.primary_vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "second" {
  name                = var.second_vnet_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_virtual_network_peering" "vnet_peer_1" {
  name                         = var.vnet_peering_names[0]
  resource_group_name          = var.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.primary.name
  remote_virtual_network_id    = data.azurerm_virtual_network.second.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
 
}

resource "azurerm_virtual_network_peering" "vnet_peer_2" {
  name                         = var.vnet_peering_names[1]
  resource_group_name          = var.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.second.name
  remote_virtual_network_id    = data.azurerm_virtual_network.primary.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
}


