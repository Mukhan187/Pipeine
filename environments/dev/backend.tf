# -----------------------------------------------------------------------------
# Dynamic / Generic Azure Remote State Backend
# -----------------------------------------------------------------------------
# No hardcoded values. Backend parameters are passed dynamically during:
# terraform init -backend-config="resource_group_name=..." \
#                -backend-config="storage_account_name=..." \
#                -backend-config="container_name=..." \
#                -backend-config="key=..."
# -----------------------------------------------------------------------------
terraform {
  backend "azurerm" {}
}
