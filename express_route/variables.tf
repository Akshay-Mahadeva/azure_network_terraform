variable "resource_group_name" {
    type = string
    description = "RG name"
}

variable "location" {
    type = string
    description = "RG location"
}

variable "vwan_name" {
    type = string
    description = "virtual wan name"
}

variable "vhub_name" {
    type = string
    description = "virtual hub name"
}

variable "erg_name" {
    type = string
    description = "Express Route Gateway name"
}

variable "erc_name" {
    type = string
    description = "Express Route Circuit name"
}

variable "erc_auth_name" {
    type = string
    description = "(optional) describe your variable"
}

# variable "erp_name" {
#     type = string
#     description = "Express Route Port name"
  
# }

# variable "peering_location" {
#     type = string
#     description = "peering location"
# }


# variable "ercp_name" {
#     type = string
#     description = " Express Route Circuit Peering name"
# }

# variable "erconn_name" {
#     type = string
#     description = " Express Route Connection name"
# }