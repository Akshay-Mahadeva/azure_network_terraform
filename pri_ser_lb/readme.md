This Module can be used for deploying a Private endpoint, service endpoint and a load balancer with existing Resource group, Virtual network and Subnets.

To call the module use the module block below, with your own source location (either local or git link).
module "pri_ser_lb" {
  source              = "./pri_ser_lb"
  resource_group_name = data.azurerm_resource_group.akshay.name
  location            = data.azurerm_resource_group.akshay.location
  service             = local.service_name
  endpoint            = local.endpoint_name

}

##Written by Akshay