variable "resource_group_name" {
  type = string
  description = "Name of the resource group "
}

variable "vnet_peering_names" {
  type        = list(string)
  description = "Name of the virtual network peerings to created in both virtual networks provided in list format."
}


variable "address_space" {
  type = string
  description = "Address space of the vnet to be created."
}

variable "location" {
  type = string
  description = "location of the vnet to be created."
}

variable "primary_vnet_name" {
  description = "Primary Vnet name"
}

variable "second_vnet_name" {
  description = "Primary Vnet name"
}


# variable "current_vnet_id" {
#   description = " Current Subscription vnet ID. "
# }

##it is commented because it is not required for the current project i.e. only when using the Cloudfoundation RG sub.
# variable "resource_group" {
#   description = "Current Subscription Resource group name"
# }
# variable "remote_rg" {
#   description = "Remote Subscription Resource group name"
# }

### Vnet name of the connecting vnet   #####





##################### id's should be used in real project #####################
# variable "subscription_remote" {
#   description = "Remote subscription ID"
# }
# variable "client_id_remote" {
#   description = "Remote Client ID"
# }
# variable "client_secret_remote" {
#   description = "Remote Client Secret that is in Terraform Enterprise Variables as a sensitive value"
# }
# variable "tenant_id_remote" {
#   description = "Remote Tenant ID"
# }

### ID's can be obtained from Azure portal ###
##################### id's should be used in real project #####################

variable "allow_virtual_network_access" {
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to false."
  default     = false
}

variable "allow_forwarded_traffic" {
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false."
  default     = true
}

variable "allow_gateway_transit" {
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Must be set to false for Global VNET peering."
  default     = true
}

# variable "destroy_peering" {
#   type        = string
#   description = "destroy the peering"
# }



variable "vnet1_use_remote_gateways" {
  description = "(Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Defaults to false."
  default     = false
}
variable "vnet2_use_remote_gateways" {
  description = "(Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Defaults to false."
  default     = false
}


variable "vnet1_allow_gateway_transit" {
    default     = false
}
variable "vnet2_allow_gateway_transit" {
    default     = false
}