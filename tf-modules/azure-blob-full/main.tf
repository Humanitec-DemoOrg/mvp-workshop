terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}        
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  use_oidc        = true
  oidc_token      = var.oidc_token
}
variable "oidc_token" {
    type = string
}
variable "subscription_id" {
    type = string
    default = "test"
}
variable "tenant_id" {
    type = string
    default = "test"
}
variable "client_id" {
    type = string
    default = "test"
}
resource "random_string" "storage_account_name_sufix" {
  length  = 16
  special = false
  lower   = true
  upper   = false
}
resource "random_string" "storage_container_name_sufix" {
  length  = 16
  special = false
  lower   = true
  upper   = false
}
resource "azurerm_storage_account" "storage_account" {
  name                     = "storage${random_string.storage_account_name_sufix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.storage_account_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "storage_container" {
  name                  = "storage${random_string.storage_container_name_sufix.result}"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
output "account" {
  value = "hard-coded-account-from-repo-cloud-account"
}
output "container" {
  value = "hard-coded-container-from-repo-cloud-account"
}