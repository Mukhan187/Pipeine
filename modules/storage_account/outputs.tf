output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary region"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "container_names" {
  description = "List of created container names"
  value       = [for c in azurerm_storage_container.container : c.name]
}
