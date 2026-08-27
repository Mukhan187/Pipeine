output "vm_id" {
  description = "The ID of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "nic_id" {
  description = "The ID of the Network Interface"
  value       = azurerm_network_interface.nic.id
}

output "private_ip_address" {
  description = "The private IP address of the Virtual Machine"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the Virtual Machine (if enabled)"
  value       = var.enable_public_ip ? azurerm_public_ip.pip[0].ip_address : null
}
