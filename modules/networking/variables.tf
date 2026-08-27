variable "resource_group_name" {
  description = "Name of the resource group in which to create the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region where the network resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnets to create with their address prefixes"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    "default-subnet" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the network resources"
  type        = map(string)
  default     = {}
}
