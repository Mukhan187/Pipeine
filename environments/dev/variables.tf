variable "environment" {
  description = "The target environment name (e.g. dev, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project used in naming conventions"
  type        = string
  default     = "studyapp"
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Subnets configuration map"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    "app-subnet" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "storage_account_name" {
  description = "Unique storage account name (lowercase alphanumeric only, max 24 chars)"
  type        = string
  default     = "stdevstudyapp01"
}

variable "vm_size" {
  description = "Size SKU of the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM (used if admin_ssh_public_key is null)"
  type        = string
  default     = "P@ssw0rd12345!"
  sensitive   = true
}

variable "admin_ssh_public_key" {
  description = "SSH public key string (Optional, if provided disables password auth)"
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
