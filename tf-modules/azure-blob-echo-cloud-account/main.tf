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
output "account" {
  value = "hard-coded-account-from-repo-cloud-account"
}
output "container" {
  value = "hard-coded-container-from-repo-cloud-account"
}