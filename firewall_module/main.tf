# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

resource "azurerm_virtual_network" "firewall_vnet" {
  name                = var.firewall_vnet_name
  address_space       = ["10.2.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.firewall_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_public_ip" "firewall_ip" {
  name                = "firewall_pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}

resource "azurerm_firewall" "net_firewall" {
  name                = "network_firewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = "firewall_ip"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_ip.id
  }
}
#Rules to allow or deny traffic
resource "azurerm_firewall_network_rule_collection" "rule" {
  name                = "network_rule"
  azure_firewall_name = azurerm_firewall.net_firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = var.action

  rule {
    name = "firewall_rule"

    source_addresses = [
      "10.2.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}



