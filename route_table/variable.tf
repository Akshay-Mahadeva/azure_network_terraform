variable "route_table_name" {
    type = string
    description = "(optional) describe your variable"
}

variable "resource_group_name" {
    type = string
    description = " Existing RG name"
}

variable "location" {
    type = string
    description = "location of RG"
}

# variable "disable_bgp_route_propagation" {
#     type = bool
# }