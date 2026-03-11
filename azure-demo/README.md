# Azure Terraform Demo

This Terraform configuration deploys a Resource Group, Storage Account with Blob Container on Azure, and automatically creates a `hello.txt` file.

## Prerequisites

1. **Terraform** installed (v1.0+)
   ```bash
   terraform --version
   ```

2. **Azure CLI** installed and authenticated
   ```bash
   az --version
   az login
   ```

3. **Azure Account** with appropriate permissions to create:
   - Resource Groups
   - Storage Accounts
   - Blob Containers
   - Blobs

## What Gets Created

This configuration creates the following Azure resources:

- **Resource Group** (terraform-demo-rg-dev)
- **Storage Account** (standard LRS replication)
- **Blob Container** (demo-container, private access)
- **Blob File** (hello.txt with sample content)

## Project Structure

```
azure-demo/
├── main.tf          # Main resource definitions
├── variables.tf     # Input variables with defaults
├── outputs.tf       # Output values
└── README.md        # This file
```

## Quick Start

### 1. Set Your Azure Subscription ID

First, get your subscription ID:

```bash
az account show --query id
```

You'll need this for the deployment.

### 2. Initialize Terraform

Download the required Azure provider and set up the local backend:

```bash
terraform init
```

### 3. Review the Plan

See what resources will be created. You must provide your subscription ID:

```bash
terraform plan -var="azure_subscription_id=YOUR_SUBSCRIPTION_ID"
```

Or create a `terraform.tfvars` file (see Customization section below).

You'll see something like:
```
+ azurerm_resource_group.main
+ azurerm_storage_account.main
+ azurerm_storage_container.main
+ azurerm_storage_blob.hello_file
```

### 4. Apply the Configuration

Create the resources in Azure:

```bash
terraform apply -var="azure_subscription_id=YOUR_SUBSCRIPTION_ID"
```

Or if you have `terraform.tfvars`:
```bash
terraform apply
```

Terraform will ask for confirmation. Type `yes` to proceed.

### 5. View Outputs

After successful deployment, Terraform will display the created resource details:

```bash
Outputs:

resource_group_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/terraform-demo-rg-dev"
resource_group_name = "terraform-demo-rg-dev"
storage_account_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/terraform-demo-rg-dev/providers/Microsoft.Storage/storageAccounts/tfdemodev"
storage_account_name = "tfdemodev"
storage_account_primary_blob_endpoint = "https://tfdemodev.blob.core.windows.net/"
blob_container_name = "demo-container"
hello_file_url = "https://tfdemodev.blob.core.windows.net/demo-container/hello.txt"
```

## Customization

To change the default values, you can:

### Option 1: Create a `terraform.tfvars` file

```hcl
azure_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
azure_location        = "West Europe"
resource_group_name   = "my-terraform-rg"
storage_account_name  = "mystorageaccount"
container_name        = "my-container"
project_name          = "my-project"
environment           = "prod"
```

Then apply:
```bash
terraform apply
```

### Option 2: Use command-line flags

```bash
terraform apply \
  -var="azure_subscription_id=YOUR_ID" \
  -var="azure_location=West Europe" \
  -var="environment=prod"
```

## Verify Deployment

### Check in Azure Portal:
1. Go to [Azure Portal](https://portal.azure.com)
2. Search for "Resource Groups"
3. Look for "terraform-demo-rg-dev"
4. Open it and verify Storage Account and Blob Container

### Check via Azure CLI:

```bash
# List resource groups
az group list --output table

# List storage accounts in resource group
az storage account list --resource-group terraform-demo-rg-dev

# List containers in storage account
az storage container list --account-name tfdemodev

# List blobs in container
az storage blob list --account-name tfdemodev --container-name demo-container

# Download and view hello.txt
az storage blob download \
  --account-name tfdemodev \
  --container-name demo-container \
  --name hello.txt
```

### Access the file:

The `hello.txt` file is in a private container, but you can:

1. **Generate a SAS URL** (temporary access):
   ```bash
   az storage blob generate-sas \
     --account-name tfdemodev \
     --container-name demo-container \
     --name hello.txt \
     --permissions r \
     --expiry 2025-12-31
   ```

2. **Change container to public** (not recommended for production):
   ```bash
   az storage container set-permission \
     --account-name tfdemodev \
     --name demo-container \
     --public-access blob
   ```

## Cleanup

To destroy all created resources:

```bash
terraform destroy -var="azure_subscription_id=YOUR_SUBSCRIPTION_ID"
```

Or if you have `terraform.tfvars`:
```bash
terraform destroy
```

Terraform will show what will be deleted and ask for confirmation. Type `yes` to proceed.

**⚠️ Warning:** This will permanently delete the Resource Group, Storage Account, Container, and all files.

## State Management

Terraform stores the state of your infrastructure in `terraform.tfstate`:

- ✅ This file is created locally
- ❌ **NEVER commit this to Git** (contains sensitive information)
- For team collaboration, use remote state (Azure Blob Storage or Terraform Cloud)

## Common Issues

### Issue: "Error: Unauthorized to perform action 'Microsoft.Resources/subscriptions/resourceGroups/write'"
**Solution:** Your Azure account doesn't have sufficient permissions. Check:
```bash
az role assignment list --assignee $(az account show --query user.name -o tsv)
```

### Issue: "Storage account name already exists"
**Solution:** Storage account names must be globally unique. Change the `storage_account_name`:
```bash
terraform apply -var="storage_account_name=mystorageaccount123"
```

### Issue: "Subscription ID not found"
**Solution:** Ensure your subscription ID is correct:
```bash
az account show --query "{subscriptionId:id, tenantId:tenantId}"
```

### Issue: "Resource group already exists"
**Solution:** Use a different resource group name:
```bash
terraform apply -var="resource_group_name=my-custom-rg"
```

## Next Steps

1. **Add more resources:** Edit `main.tf` to add Virtual Machines, Databases, etc.
2. **Upload more files:** Add more `azurerm_storage_blob` resources
3. **Use modules:** Break code into reusable modules
4. **Remote state:** Set up Azure Blob Storage backend for team collaboration
5. **CI/CD integration:** Use GitHub Actions or Azure DevOps for automated deployments

## Resources

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Storage Documentation](https://learn.microsoft.com/en-us/azure/storage/)
- [Azure Resource Groups](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview)
- [Terraform State Documentation](https://www.terraform.io/language/state)

## Support

For issues or questions:
1. Check Terraform error messages carefully
2. Run `terraform plan` to see what will happen
3. Check Azure Activity Log in Portal for API errors
4. Review [Terraform Registry](https://registry.terraform.io/) for provider docs
5. Check [Azure Documentation](https://learn.microsoft.com/en-us/azure/)

