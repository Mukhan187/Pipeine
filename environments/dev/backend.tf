# Azure Blob Storage Remote Backend Configuration
# For local study, this can be left commented out to use local state,
# or populated with your Azure backend details.
# In CI/CD pipelines, backend values can be supplied dynamically via:
# terraform init -backend-config="resource_group_name=..." -backend-config="storage_account_name=..." ...

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-tfstate"
    storage_account_name = "stterraformtfstatedev01"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
