variable "resource_group_name" {
    type = string
    description = "The resource group name"
}

variable "location" {
    type = string
    description = "The location of the resource group"
}

variable "private_vnet_name" {
    type = string
    description = "The primary vnet name"
}

variable "service" {
    type = string
    description = "Name of the service subnet"
}

variable "endpoint" {
    type = string
    description = "Name of the endpoint subnet"
}

variable "public_ip_name" {
    type = string
    description = "Name of the public ip"
}

variable "load_balancer_name" {
    type = string
    description = "Name of the load balancer"
}

variable "private_link_service_name" {
    type = string
    description = "Name of the private link service"
}

variable "private_endpoint_name" {
    type = string
    description = "Name of the private endpoint"
}