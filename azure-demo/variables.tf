variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "azure_location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "Poland Central"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "terraform-demo-rg"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "terraform-demo"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "storage_account_name" {
  description = "Name of the storage account (will have environment appended)"
  type        = string
  default     = "tfdemo"
}

variable "container_name" {
  description = "Name of the blob container"
  type        = string
  default     = "demo-container"
}

