variable "vm_name" {
  description = "The name of the Linux Virtual Machine"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where the VM will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the Subnet where the Network Interface will be attached"
  type        = string
}

variable "vm_size" {
  description = "The SKU / size of the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The username of the local administrator"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Password for admin user (if SSH key is not provided)"
  type        = string
  default     = null
  sensitive   = true
}

variable "admin_ssh_public_key" {
  description = "The public SSH key for authentication (Recommended)"
  type        = string
  default     = null
}

variable "enable_public_ip" {
  description = "Boolean flag to determine if a Public IP should be created and attached"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
