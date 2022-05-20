#RG already exists
# data "azurerm_resource_group" "network" {
#   name = var.resource_group_name
# }

resource "azurerm_virtual_network" "primary_vnet" {
  name                = var.primary_vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.address_space]
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_virtual_network" "second_vnet" {
  name                = var.second_vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.1.0.0/16"]
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = var.resource_group_name
  address_prefixes     = [var.subnet_prefixes[count.index]]
  virtual_network_name = azurerm_virtual_network.primary_vnet.name
}
