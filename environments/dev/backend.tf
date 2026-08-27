# -----------------------------------------------------------------------------
# Azure Remote State Backend Configuration (Optional for Local Study)
# -----------------------------------------------------------------------------
# Local run ke liye by default local state use hogi.
# Agar Azure Storage Remote Backend use karna ho, toh neeche wala block uncomment karein:
#
# terraform {
#   backend "azurerm" {}
# }
#
# Aur init aise karein:
# terraform init -backend-config="resource_group_name=rg-terraform-tfstate" \
#                -backend-config="storage_account_name=stterraformtfstatedev01" \
#                -backend-config="container_name=tfstate" \
#                -backend-config="key=dev.terraform.tfstate"
# -----------------------------------------------------------------------------
