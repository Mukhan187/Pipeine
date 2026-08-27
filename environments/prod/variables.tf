variable "environment" {
  description = "The target environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Name of the project used in naming conventions"
  type        = string
  default     = "studyapp"
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus2"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.100.0.0/16"]
}

variable "subnets" {
  description = "Subnets configuration map"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    "app-subnet" = {
      address_prefixes = ["10.100.1.0/24"]
    }
  }
}

variable "storage_account_name" {
  description = "Unique storage account name for prod (lowercase alphanumeric only, max 24 chars)"
  type        = string
  default     = "stprodstudyapp01"
}

variable "vm_size" {
  description = "Size SKU of the Virtual Machine"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  default     = null
  sensitive   = true
}

variable "admin_ssh_public_key" {
  description = "SSH public key string (Recommended for Prod)"
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
