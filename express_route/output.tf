output "name" {
  value = azurerm_virtual_wan.virtual_wan.name
}

output "name_vhub" {
  value = azurerm_virtual_hub.vhub.name
}

output "id_vhub" {
  value = azurerm_virtual_hub.vhub.id
}

output "id_erg" {
  value = azurerm_express_route_gateway.express_rg.id
}
  



  
