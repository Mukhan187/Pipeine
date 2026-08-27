output "resource_group_name" {
  description = "The name of the created Resource Group"
  value       = module.resource_group.resource_group_name
}

output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = module.networking.vnet_name
}

output "subnet_ids" {
  description = "The IDs of the subnets created"
  value       = module.networking.subnet_ids
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = module.storage_account.storage_account_name
}

output "storage_blob_endpoint" {
  description = "The primary blob endpoint"
  value       = module.storage_account.primary_blob_endpoint
}

output "vm_public_ip" {
  description = "The Public IP of the Virtual Machine"
  value       = module.linux_vm.public_ip_address
}

output "vm_private_ip" {
  description = "The Private IP of the Virtual Machine"
  value       = module.linux_vm.private_ip_address
}
