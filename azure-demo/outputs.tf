output "resource_group_id" {
  description = "The ID of the Azure Resource Group"
  value       = azurerm_resource_group.main.id
}

output "resource_group_name" {
  description = "The name of the Azure Resource Group"
  value       = azurerm_resource_group.main.name
}

output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint of the Storage Account"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "blob_container_name" {
  description = "The name of the blob container"
  value       = azurerm_storage_container.main.name
}

output "hello_file_url" {
  description = "The URL to access the hello.txt file"
  value       = "${azurerm_storage_account.main.primary_blob_endpoint}${azurerm_storage_container.main.name}/hello.txt"
}

