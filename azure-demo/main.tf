# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.azure_location

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create Storage Account
resource "azurerm_storage_account" "main" {
  name                     = replace("${var.storage_account_name}${var.environment}", "-", "")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create Blob Container
resource "azurerm_storage_container" "main" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Create and upload hello.txt file
resource "azurerm_storage_blob" "hello_file" {
  name                   = "hello.txt"
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.main.name
  type                   = "Block"
  source_content         = "Hello from Terraform! This file was created automatically.\n"
}

