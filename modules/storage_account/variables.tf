variable "storage_account_name" {
  description = "Specifies the name of the storage account (lowercase alphanumeric, 3-24 characters)"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account (LRS, GRS, RAGRS, ZRS)"
  type        = string
  default     = "LRS"
}

variable "containers" {
  description = "List of blob container names to create"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
