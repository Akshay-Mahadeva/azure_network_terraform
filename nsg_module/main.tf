data "azurerm_resource_group" "nsg" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.security_group_name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.nsg.location
  resource_group_name = data.azurerm_resource_group.nsg.name
  tags                = var.tags
}
# NSG rules are hard coded in the module block
#############################
#   Simple security rules   #
#############################

# resource "azurerm_network_security_rule" "predefined_rules" {
#   count                                      = length(var.predefined_rules)
#   name                                       = lookup(var.predefined_rules[count.index], "name")
#   priority                                   = lookup(var.predefined_rules[count.index], "priority", 4096 - length(var.predefined_rules) + count.index)
#   direction                                  = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 0)
#   access                                     = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 1)
#   protocol                                   = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 2)
#   source_port_ranges                         = split(",", replace(lookup(var.predefined_rules[count.index], "source_port_range", "*"), "*", "0-65535"))
#   destination_port_range                     = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 4)
#   description                                = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 5)
#   source_address_prefix                      = length(lookup(var.predefined_rules[count.index], "source_application_security_group_ids", [])) == 0 ? join(",", var.source_address_prefix) : ""
#   destination_address_prefix                 = length(lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", [])) == 0 ? join(",", var.destination_address_prefix) : ""
#   resource_group_name                        = data.azurerm_resource_group.nsg.name
#   network_security_group_name                = azurerm_network_security_group.nsg.name
#   source_application_security_group_ids      = lookup(var.predefined_rules[count.index], "source_application_security_group_ids", [])
#   destination_application_security_group_ids = lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", [])
# }

#############################
#  Detailed security rules  #
#############################

# resource "azurerm_network_security_rule" "custom_rules" {
#   count                                      = length(var.custom_rules)
#   name                                       = lookup(var.custom_rules[count.index], "name", "default_rule_name")
#   priority                                   = lookup(var.custom_rules[count.index], "priority")
#   direction                                  = lookup(var.custom_rules[count.index], "direction", "Any")
#   access                                     = lookup(var.custom_rules[count.index], "access", "Allow")
#   protocol                                   = lookup(var.custom_rules[count.index], "protocol", "*")
#  # source_port_ranges                         = split(",", replace(lookup(var.custom_rules[count.index], "source_port_range", "*"), "*", "0-65535"))
#   source_port_range                          = lookup(var.custom_rules[count.index], "source_port_range", "*")
#   destination_port_ranges                    = split(",", replace(lookup(var.custom_rules[count.index], "destination_port_range", "*"), "*", "0-65535"))
#   source_address_prefixes                    = lookup(var.custom_rules[count.index], "source_address_prefixes", "*")
# #   destination_address_prefixes               = lookup(var.custom_rules[count.index], "destination_address_prefixes", "*")
#   description                                = lookup(var.custom_rules[count.index], "description", "Security rule for ${lookup(var.custom_rules[count.index], "name", "default_rule_name")}")
#   resource_group_name                        = data.azurerm_resource_group.nsg.name
#   network_security_group_name                = azurerm_network_security_group.nsg.name
#   source_application_security_group_ids      = lookup(var.custom_rules[count.index], "source_application_security_group_ids", [])
#   destination_application_security_group_ids = lookup(var.custom_rules[count.index], "destination_application_security_group_ids", [])
# }

#############################
#  Deny security rules  #
#############################

# resource "azurerm_network_security_rule" "deny_internet_rule" {
#   count                                      = var.enable_deny_rules ? length(var.deny_rules) : 0
#   name                                       = lookup(var.deny_rules[count.index], "name", "default_rule_name")
#   priority                                   = lookup(var.deny_rules[count.index], "priority")
#   direction                                  = lookup(var.deny_rules[count.index], "direction", "Any")
#   access                                     = lookup(var.deny_rules[count.index], "access", "Allow")
#   protocol                                   = lookup(var.deny_rules[count.index], "protocol", "*")
#   source_port_ranges                         = split(",", replace(lookup(var.deny_rules[count.index], "source_port_range", "*"), "*", "0-65535"))
#   destination_port_ranges                    = split(",", replace(lookup(var.deny_rules[count.index], "destination_port_range", "*"), "*", "0-65535"))
#   source_address_prefix                      = lookup(var.deny_rules[count.index], "source_address_prefix", "*")
#   destination_address_prefix                 = lookup(var.deny_rules[count.index], "destination_address_prefix", "*")
#   description                                = lookup(var.deny_rules[count.index], "description", "Security rule for ${lookup(var.deny_rules[count.index], "name", "default_rule_name")}")
#   resource_group_name                        = data.azurerm_resource_group.nsg.name
#   network_security_group_name                = azurerm_network_security_group.nsg.name
#   source_application_security_group_ids      = lookup(var.deny_rules[count.index], "source_application_security_group_ids", [])
#   destination_application_security_group_ids = lookup(var.deny_rules[count.index], "destination_application_security_group_ids", [])
# }





###
# diagnostics settings
###
