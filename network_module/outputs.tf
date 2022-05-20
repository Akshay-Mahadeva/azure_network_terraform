output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.primary_vnet.id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.primary_vnet.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.primary_vnet.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.primary_vnet.address_space
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newl vNet"
  value       = azurerm_subnet.subnet.*.id
}
