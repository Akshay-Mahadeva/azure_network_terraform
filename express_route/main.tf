# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

# Using existing resource group

resource "azurerm_virtual_wan" "virtual_wan" {
  name                = var.vwan_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_hub" "vhub" {
  name                = var.vhub_name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan.id
  address_prefix      = "10.0.1.0/24"
}

resource "azurerm_express_route_gateway" "express_rg" {
  name                = var.erg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_hub_id      = azurerm_virtual_hub.vhub.id
  scale_units         = 1
}

resource "azurerm_express_route_circuit" "express_rc" {
  name                  = var.erc_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  service_provider_name = "Equinix"
  peering_location      = "Silicon Valley"   # this is not resource location
  bandwidth_in_mbps     = 50

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }

  allow_classic_operations = false

  tags = {
    environment = "devops_network"
  }
}

resource "azurerm_express_route_circuit_authorization" "erc_auth" {
  name                       = var.erc_auth_name
  express_route_circuit_name = azurerm_express_route_circuit.express_rc.name
  resource_group_name        = var.resource_group_name
}

