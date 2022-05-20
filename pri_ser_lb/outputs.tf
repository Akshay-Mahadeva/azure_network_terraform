# This can be used while creating a new private link service

# output "pl_name" {
#   value = azurerm_private_link_service.private_link.name
# }
  
# output "pl_id" {
#   value = azurerm_private_link_service.private_link.id
# }
output "load_balancer_name" {
  value = azurerm_lb.load_balancer.name
}

output "load_balancer_id" {
  value = azurerm_lb.load_balancer.id
}


  
# output "pe_name" {
#   value = azurerm_private_endpoint.private_endpoint.name
# }

# output "pe_id" {
#   value = azurerm_private_endpoint.private_endpoint.id
# }
  
