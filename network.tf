#To add modules
###### Phase 1 ########
# 1.Network(Vnet and Subnet) -Done
# 2.Network security group - Done
# 3.Virtual network peering - Done
# 4.Route table - Done
### Phase 2 ##########
# 5.Firewall - Done
# 6.Load balancer -Done
# 7.express route - Done
# 8.Private end points -Done
# 9.Service end points -Done
# 10.DNS private Zone -Done

provider "azurerm" {
  features {

  }
}
##Declare your own variables
locals {
  resource_group_name = "Cloudfoundation"
  name                = "cloud-foundation"
  primary_vnet_name   = "hub-vnet-${local.name}"
  second_vnet_name    = "dev-vnet-${local.name}"
  third_vnet_name     = "test-vnet-${local.name}"
  fourth_vnet_name    = "prod-vnet-${local.name}"
  location            = "EastUS"
  tags = {
     Environment = "Development"
    Region     = "eastus"
    Deployment  = "Terraform"}

}

data "azurerm_resource_group" "rg" {
  name = "Cloudfoundation"
}



#Module for Vnets and a Subnets
module "network" {
  source               = "./network_module"
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = local.location
  primary_vnet_name    = "hub-vnet-${local.name}"
  second_vnet_name     = "dev-vnet-${local.name}"
  third_vnet_name      = "test-vnet-${local.name}"
  fourth_vnet_name     = "prod-vnet-${local.name}"
  address_space        = "10.0.0.0/16"
  subnet_prefixes      = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  subnet_names         = ["snet-dev-1", "snet-dev-2", "snet-dev-3"]
  test_subnet_prefixes = ["10.3.1.0/24", "10.3.2.0/24", "10.3.3.0/24"]
  test_subnet_names    = ["snet-test-1", "snet-test-2", "snet-test-3"]
  prod_subnet_prefixes = ["10.6.1.0/24", "10.6.2.0/24", "10.6.3.0/24"]
  prod_subnet_names    = ["snet-prod-1", "snet-prod-2", "snet-prod-3"]

  tags = local.tags

  depends_on = [data.azurerm_resource_group.rg]
}



#Network security group

module "network-security-group" {
  source                   = ""
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = local.location
  security_group_name      = "nsg-${local.name}-1"
  test_security_group_name = "nsg-${local.name}-2"
  prod_security_group_name = "nsg-${local.name}-3"
  second_vnet_name         = local.second_vnet_name
  third_vnet_name          = local.third_vnet_name
  fourth_vnet_name         = local.fourth_vnet_name
  ####
  snet_dev_1 = "snet-dev-1"
  snet_dev_2 = "snet-dev-2"
  snet_dev_3 = "snet-dev-3"
  ####
  snet_test_1 = "snet-test-1"
  snet_test_2 = "snet-test-2"
  snet_test_3 = "snet-test-3"
  ######
  snet_prod_1 = "snet-prod-1"
  snet_prod_2 = "snet-prod-2"
  snet_prod_3 = "snet-prod-3"
  ## Can add multiple namespaces and assign them values accordingly (Ex: Subnets to assocaite with NSG)

  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
    },
    {
      name              = "LDAP"
      source_port_range = "1024-1026"
    }
  ]

  custom_rules = [
    {
      name                   = "myhttp"
      priority               = "200"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      destination_port_range = "8080"
      description            = "description-myhttp"
    }
  ]

  deny_rules = [
    {
      name                       = "Deny_Internet"
      priority                   = "1000"
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  ]
  tags = local.tags

  depends_on = [module.network]
}

# Vnet peering
module "vnetpeering" {
  source              = ""
  primary_vnet_name   = local.primary_vnet_name
  second_vnet_name    = local.second_vnet_name
  third_vnet_name     = local.third_vnet_name
  fourth_vnet_name    = local.fourth_vnet_name
  address_space       = "10.0.0.0/16"
  vnet_peering_names  = ["peer-dev-1", "peer-dev-2", "peer-test-1", "peer-test-2", "peer-prod-1", "peer-prod-2"]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  tags                = local.tags

  depends_on = [module.network]

}

# Route table

module "route-table" {
  source              = ""
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  route_table_name    = "rt-${local.name}-dev"
  tags                = local.tags
}
################### Phase two #############################

#Firewall

module "firewall" {
  source               = "git::https://akshay:iwhb64thiwvu5sgmbq4jopcyz46ejhgenvkfa5ijrrohr422abwq@dev.azure.com/ismiletechnologies/CloudAgnosticIaC/_git/terraform-azurerm-network-firewall-aks"
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = local.location
  hub_vnet_name        = local.primary_vnet_name
  firewall_subnet_name = "AzureFirewallSubnet" ### cant rename it
  tags                 = local.tags

  depends_on = [module.network]
}

#Express routes

module "express-route" {
  source              = "git::https://akshay:iwhb64thiwvu5sgmbq4jopcyz46ejhgenvkfa5ijrrohr422abwq@dev.azure.com/ismiletechnologies/CloudAgnosticIaC/_git/terraform-azurerm-express-route-aks"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  vwan_name           = "vwan-${local.name}-dev"
  vhub_name           = "vhub-${local.name}-dev"
  erc_name            = "erc-${local.name}-dev"
  erc_auth_name       = "ERC_Authorization"
  tags                = local.tags
}

#private end points, service points and load balancer
module "pri_ser_lb" {
  source                    = "git::https://akshay:iwhb64thiwvu5sgmbq4jopcyz46ejhgenvkfa5ijrrohr422abwq@dev.azure.com/ismiletechnologies/CloudAgnosticIaC/_git/terraform-azurerm-PELBSL-aks"
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  private_vnet_name         = "pl-vnet-${local.name}-dev"
  service                   = "snet-${local.name}-se"
  endpoint                  = "snet-${local.name}-pe"
  public_ip_name            = "pip-${local.name}-dev"
  load_balancer_name        = "lbin-${local.name}-dev"
  private_link_service_name = "pls-${local.name}-dev"
  private_endpoint_name     = "pe-${local.name}-dev"
  tags                      = local.tags

  depends_on = [module.network]

}

#DNS private zone
module "dns-private-zone" {
  source                = "git::https://akshay:iwhb64thiwvu5sgmbq4jopcyz46ejhgenvkfa5ijrrohr422abwq@dev.azure.com/ismiletechnologies/CloudAgnosticIaC/_git/terraform-azurerm-DNS-aks"
  private_dns_zone_name = "randomdomain.com"
  resource_group_name   = data.azurerm_resource_group.rg.name
  tags                  = local.tags
}

