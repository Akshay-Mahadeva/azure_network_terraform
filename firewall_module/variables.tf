variable "location" {
  type = string
  description = "resource location"
}

variable "resource_group_name" {
  type = string
  description = "resource group name"
}

variable "firewall_vnet_name" {
  type = string
  description = "firewall vnet name"
}

variable "firewall_subnet_name" {
  type = string
  description = "firewall subnet name"
}

variable "allocation_method" {
  type = string
  description = "(optional) describe your variable"
  default = "Static"
}

variable "sku" {
  type = string
  description = "Standard,Premium,Standard_v2,Standard_v3"
  default = "Standard"
}

variable "action" {
  type = string
  description = "allow,deny"
  default = "Allow"
}

variable "sku_tier" {
  type = string
  description = "basic,standard,premium"
  default = "Standard"
}

variable "sku_name" {
  type = string
  description = "(optional) describe your variable"
  default = "AZFW_VNet"
}