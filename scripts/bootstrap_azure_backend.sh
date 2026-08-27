#!/usr/bin/env bash
# =============================================================================
# Bootstrap Azure Storage for Terraform Remote State Backend
# =============================================================================

set -e

# Configuration
RESOURCE_GROUP_NAME="rg-terraform-tfstate"
LOCATION="eastus"
STORAGE_ACCOUNT_NAME="stterraformtfstatedev$RANDOM"
CONTAINER_NAME="tfstate"

echo "=========================================="
echo "Creating Azure Remote State Storage..."
echo "=========================================="

# 1. Create Resource Group
echo "1. Creating Resource Group: $RESOURCE_GROUP_NAME in $LOCATION..."
az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"

# 2. Create Storage Account
echo "2. Creating Storage Account: $STORAGE_ACCOUNT_NAME..."
az storage account create \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --encryption-services blob \
  --min-tls-version TLS1_2

# 3. Get Storage Account Key
ACCOUNT_KEY=$(az storage account keys list --resource-group "$RESOURCE_GROUP_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --query '[0].value' -o tsv)

# 4. Create Blob Container
echo "3. Creating Blob Container: $CONTAINER_NAME..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$ACCOUNT_KEY"

echo "=========================================="
echo "Backend Storage Created Successfully!"
echo "=========================================="
echo "Update your environments/dev/backend.tf with:"
echo "resource_group_name  = \"$RESOURCE_GROUP_NAME\""
echo "storage_account_name = \"$STORAGE_ACCOUNT_NAME\""
echo "container_name       = \"$CONTAINER_NAME\""
echo "key                  = \"dev.terraform.tfstate\""
