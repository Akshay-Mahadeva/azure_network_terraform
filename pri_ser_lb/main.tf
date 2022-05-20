# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }
# Using existing resource group

resource "azurerm_virtual_network" "private_vnet" {
  name                = var.private_vnet_name
  address_space       = ["10.4.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "service" {
  name                 = "service"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.private_vnet.name
  address_prefixes     = ["10.4.1.0/24"]

  enforce_private_link_service_network_policies = true
}

resource "azurerm_subnet" "endpoint" {
  name                 = "endpoint"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.private_vnet.name
  address_prefixes     = ["10.4.2.0/24"]

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.public_ip.name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_private_link_service" "private_link_service" {
  name                = var.private_link_service_name
  location            = var.location
  resource_group_name = var.resource_group_name

  nat_ip_configuration {
    name      = azurerm_public_ip.public_ip.name
    primary   = true
    subnet_id = azurerm_subnet.service.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.load_balancer.frontend_ip_configuration.0.id,
  ]
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "aks_private_conn"
    private_connection_resource_id = azurerm_private_link_service.private_link_service.id
    is_manual_connection           = false
  }
}
