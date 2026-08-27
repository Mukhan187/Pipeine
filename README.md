# 🚀 Terraform Modular Infrastructure (Parent-Child Pattern) & Azure CI/CD Pipeline

> **Study & Production Blueprint**: Comprehensive guide for understanding Terraform Parent-Child module architecture, remote state locking in Azure Blob Storage, and automated CI/CD deployment using **GitHub Actions** and **Azure DevOps Pipelines**.

---

## 📌 1. Parent-Child Module Architecture

In Terraform, modularization helps prevent code duplication and ensures infrastructure can be replicated across environments (`dev`, `prod`, `qa`, `staging`).

```
                              ┌───────────────────────────────────┐
                              │     Parent / Root Module          │
                              │     (environments/dev)            │
                              └─┬──────────────┬────────────────┬─┘
                                │              │                │
            Passes Variables    │              │                │ Passes Variables
                    ┌───────────┘              │                └────────────┐
                    ▼                          ▼                             ▼
       ┌────────────────────────┐  ┌────────────────────────┐  ┌────────────────────────┐
       │ Child Module:          │  │ Child Module:          │  │ Child Module:          │
       │ modules/resource_group │  │ modules/networking     │  │ modules/linux_vm       │
       └────────────────────────┘  └────────────────────────┘  └────────────────────────┘
                    │                          ▲                             ▲
                    └─────── Outputs RG Name ──┴────── Outputs Subnet ID ────┘
```

### 🧠 Core Concepts:
1. **Child Module (`modules/`)**:
   - Reusable building block (e.g., `resource_group`, `networking`, `storage_account`, `linux_vm`).
   - Does **NOT** hardcode environment values. Uses `variables.tf` as inputs and `outputs.tf` to share created resource IDs/endpoints.
2. **Parent / Root Module (`environments/dev`, `environments/prod`)**:
   - The entry point where you run `terraform init`, `plan`, and `apply`.
   - Calls child modules via `module "name" { source = "../../modules/..." }`.
   - Passes specific parameters and variable values from `terraform.tfvars`.
   - Manages state locking via `backend.tf`.

---

## 📂 2. Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── terraform.yml          # GitHub Actions CI/CD (Validate -> Plan -> Apply)
├── azure-pipelines.yml            # Azure DevOps Multi-Stage YAML Pipeline
├── environments/
│   ├── dev/                       # Dev Parent / Root Module
│   │   ├── backend.tf             # Remote State Backend (Azure Storage)
│   │   ├── main.tf                # Calls child modules with Dev inputs
│   │   ├── outputs.tf             # Exposes Dev environment outputs
│   │   ├── providers.tf           # Terraform & AzureRM provider config
│   │   ├── terraform.tfvars       # Dev environment variable values
│   │   ├── terraform.tfvars.example
│   │   └── variables.tf           # Variable declarations
│   └── prod/                      # Prod Parent / Root Module
│       ├── backend.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── terraform.tfvars.example
│       └── variables.tf
├── modules/                       # Reusable Child Modules
│   ├── linux_vm/                  # Compute: NIC + Public IP + Ubuntu VM
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── networking/                # Network: VNet + Subnets + NSG + Rules
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── resource_group/            # Base: Azure Resource Group + Tags
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── storage_account/           # Storage: Azure Storage Account + Containers
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── scripts/
│   ├── bootstrap_azure_backend.sh # Bash script to setup Remote State
│   └── bootstrap_azure_backend.ps1# PowerShell script for Remote State
├── .gitignore                     # Prevents committing secrets & tfstate
└── README.md                      # Documentation & Study Guide
```

---

## 🛠️ 3. Step-by-Step Setup Guide

### Step 3.1: Azure Remote State Setup (One-time)
Terraform needs an Azure Storage Account to store the `.tfstate` file remotely with lease locking.

Run either of the bootstrap scripts:
```powershell
# In PowerShell (Windows)
pwsh ./scripts/bootstrap_azure_backend.ps1
```
or via Azure CLI directly:
```bash
# 1. Login to Azure
az login

# 2. Create Resource Group & Storage Account
az group create --name "rg-terraform-tfstate" --location "eastus"
az storage account create --name "stterraformtfstatedev01" --resource-group "rg-terraform-tfstate" --location "eastus" --sku Standard_LRS
az storage container create --name "tfstate" --account-name "stterraformtfstatedev01"
```

Update `environments/dev/backend.tf` with your storage account details.

---

### Step 3.2: Local Run & Testing

Navigate to the `dev` environment:
```bash
cd environments/dev

# 1. Initialize Terraform & Download Provider / Modules
terraform init

# 2. Check code formatting & validate syntax
terraform fmt -check
terraform validate

# 3. Preview execution plan
terraform plan

# 4. Apply changes (Deploy resources)
terraform apply -auto-approve

# 5. Clean up (Destroy resources when finished studying)
terraform destroy -auto-approve
```

---

## 🐙 4. GitHub Setup & CI/CD Pipeline

### Step 4.1: Initialize Git and Push to GitHub
```bash
# In project root folder
git init
git add .
git commit -m "Initial commit: Terraform modular architecture with Azure pipelines"
git branch -M main
git remote add origin https://github.com/<YOUR_USERNAME>/<YOUR_REPO_NAME>.git
git push -u origin main
```

### Step 4.2: Create Azure Service Principal for GitHub Actions
Generate credentials for GitHub Actions to authenticate to Azure:
```bash
az ad sp create-for-rbac --name "sp-github-terraform" \
  --role "Contributor" \
  --scopes "/subscriptions/<YOUR_SUBSCRIPTION_ID>" \
  --json-auth
```

### Step 4.3: Add GitHub Repository Secrets
Go to your GitHub Repository -> **Settings** -> **Secrets and variables** -> **Actions** and add:
- `AZURE_CLIENT_ID`
- `AZURE_CLIENT_SECRET`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_TENANT_ID`

---

## ⚙️ 5. Pipeline Stages Overview

### GitHub Actions (`.github/workflows/terraform.yml`)
| Stage | Trigger | Action |
|---|---|---|
| **1. Validate** | Pull Request / Push | `terraform fmt -check`, `terraform validate` |
| **2. Plan** | Pull Request / Push | Runs `terraform plan` and saves `tfplan` artifact |
| **3. Apply** | Merge / Push to `main` | Downloads `tfplan`, prompts for environment approval, executes `terraform apply` |

### Azure DevOps (`azure-pipelines.yml`)
- Multi-stage pipeline with native `TerraformTaskV4`.
- Uses Azure Service Connection (`azureServiceConnection`).
- Environment approval gates for production safety.

---

## 💡 6. Key Takeaways for Interviews & Study

1. **Why Parent-Child?**: Child modules provide encapsulation and single-responsibility principle; Root/Parent modules manage configuration and lifecycle.
2. **State Locking**: Azure Blob storage natively handles blob lease locks preventing concurrent applies.
3. **Sensitive Data**: Passwords and secrets are flagged with `sensitive = true` in `variables.tf` so they are masked in logs.
4. **Depends On vs Implicit Dependencies**: Module references (e.g. `module.resource_group.resource_group_name`) automatically create implicit dependency graphs, ensuring resources are provisioned in correct order.
