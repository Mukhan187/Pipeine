# Azure Blob Storage Remote Backend Configuration for Prod
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-tfstate"
    storage_account_name = "stterraformtfstateprod01"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
