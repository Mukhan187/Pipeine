# =============================================================================
# Bootstrap Azure Storage for Terraform Remote State Backend (PowerShell)
# =============================================================================

$ErrorActionPreference = "Stop"

$ResourceGroupName = "rg-terraform-tfstate"
$Location = "eastus"
$RandomSuffix = Get-Random -Minimum 1000 -Maximum 9999
$StorageAccountName = "stterraformtfstate$RandomSuffix"
$ContainerName = "tfstate"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Creating Azure Remote State Storage..." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Create Resource Group
Write-Host "1. Creating Resource Group: $ResourceGroupName in $Location..."
az group create --name $ResourceGroupName --location $Location

# 2. Create Storage Account
Write-Host "2. Creating Storage Account: $StorageAccountName..."
az storage account create `
  --name $StorageAccountName `
  --resource-group $ResourceGroupName `
  --location $Location `
  --sku Standard_LRS `
  --encryption-services blob `
  --min-tls-version TLS1_2

# 3. Get Account Key
$AccountKey = az storage account keys list --resource-group $ResourceGroupName --account-name $StorageAccountName --query '[0].value' -o tsv

# 4. Create Blob Container
Write-Host "3. Creating Blob Container: $ContainerName..."
az storage container create `
  --name $ContainerName `
  --account-name $StorageAccountName `
  --account-key $AccountKey

Write-Host "==========================================" -ForegroundColor Green
Write-Host "Backend Storage Created Successfully!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host "Update your backend.tf with:"
Write-Host "resource_group_name  = `"$ResourceGroupName`""
Write-Host "storage_account_name = `"$StorageAccountName`""
Write-Host "container_name       = `"$ContainerName`""
Write-Host "key                  = `"dev.terraform.tfstate`""
