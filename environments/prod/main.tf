# -----------------------------------------------------------------------------
# Local Values for Common Naming & Tags
# -----------------------------------------------------------------------------
locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
      Criticality = "High"
    },
    var.extra_tags
  )
}

# -----------------------------------------------------------------------------
# Child Module 1: Resource Group
# -----------------------------------------------------------------------------
module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = "rg-${local.name_prefix}"
  location            = var.location
  tags                = local.common_tags
}

# -----------------------------------------------------------------------------
# Child Module 2: Networking (VNet, Subnets & NSG)
# -----------------------------------------------------------------------------
module "networking" {
  source = "../../modules/networking"

  vnet_name           = "vnet-${local.name_prefix}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = local.common_tags

  depends_on = [module.resource_group]
}

# -----------------------------------------------------------------------------
# Child Module 3: Storage Account & Container
# -----------------------------------------------------------------------------
module "storage_account" {
  source = "../../modules/storage_account"

  storage_account_name     = var.storage_account_name
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type
  containers               = var.storage_containers
  tags                     = local.common_tags

  depends_on = [module.resource_group]
}

# -----------------------------------------------------------------------------
# Child Module 4: Linux Virtual Machine
# -----------------------------------------------------------------------------
module "linux_vm" {
  source = "../../modules/linux_vm"

  vm_name              = "vm-${local.name_prefix}"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  subnet_id            = values(module.networking.subnet_ids)[0]
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  admin_ssh_public_key = var.admin_ssh_public_key
  enable_public_ip     = false
  tags                 = local.common_tags

  depends_on = [module.networking]
}
