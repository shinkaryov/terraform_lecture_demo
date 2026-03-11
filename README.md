# Terraform Lecture & Demos

A comprehensive presentation and hands-on demonstrations of Terraform infrastructure-as-code principles.

## 📚 Contents

This repository contains:

1. **Terraform Presentation** (`terraform_presentation.html`) - A modern interactive HTML presentation covering:
   - Why Infrastructure as Code matters
   - Introduction to Terraform
   - HashiCorp Configuration Language (HCL)
   - Terraform workflow and core concepts
   - State management and scaling

2. **AWS Demo** (`aws-demo/`) - Create a VPC and S3 bucket on AWS
3. **Azure Demo** (`azure-demo/`) - Create a Resource Group and Blob Storage on Azure

## 🎯 Quick Navigation

### View the Presentation
Open `terraform_presentation.html` in your web browser:
```bash
open terraform_presentation.html
# or on Linux:
# xdg-open terraform_presentation.html
```

### Run AWS Demo
```bash
cd aws-demo
cat README.md  # Full deployment instructions
```

### Run Azure Demo
```bash
cd azure-demo
cat README.md  # Full deployment instructions
```

## 📋 Presentation Outline

The presentation is divided into 5 parts:

### Part 1: The Problem and the Solution (15 Minutes)
- The "Old Way" of Infrastructure (ClickOps, bash/python scripts)
- Introduction to Infrastructure as Code (IaC)
- Declarative vs. Imperative approaches

### Part 2: What is Terraform? (15 Minutes)
- Terraform Overview (HashiCorp, open-source, cloud-agnostic)
- Terraform Architecture (Core, Providers)

### Part 3: HashiCorp Configuration Language (HCL) & Core Concepts (20 Minutes)
- HCL Syntax Basics
- The Big Three Blocks: `provider`, `resource`, `data`
- Making Code Dynamic: `variable` and `output`

### Part 4: The Core Workflow & Live Demo (25 Minutes)
- The 4-Step Workflow: init → plan → apply → destroy
- Live demonstrations with code examples

### Part 5: State Management & Next Steps (10 Minutes)
- Understanding `terraform.tfstate`
- Scaling Terraform with remote state and modules

## 🚀 Getting Started

### Prerequisites

#### For All Demos:
- **Terraform** v1.0 or higher
  ```bash
  terraform --version
  ```

#### For AWS Demo:
- **AWS Account** with appropriate permissions
- **AWS CLI** installed and configured
  ```bash
  aws --version
  aws configure
  ```

#### For Azure Demo:
- **Azure Account** with appropriate permissions
- **Azure CLI** installed and authenticated
  ```bash
  az --version
  az login
  ```

### Installation

1. **Install Terraform** - Download from [terraform.io](https://www.terraform.io/downloads)

2. **Install Cloud CLI tools:**
   - AWS: `brew install awscli` (macOS) or download from AWS
   - Azure: `brew install azure-cli` (macOS) or download from Azure

3. **Clone this repository:**
   ```bash
   git clone <repository-url>
   cd PythonProject16
   ```

## 📖 Demo Workflows

### AWS Demo: VPC + S3 Bucket

```bash
cd aws-demo

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Create resources
terraform apply

# Verify in AWS Console or CLI
aws ec2 describe-vpcs
aws s3 ls

# Clean up
terraform destroy
```

See [aws-demo/README.md](aws-demo/README.md) for detailed instructions.

### Azure Demo: Resource Group + Blob Storage

```bash
cd azure-demo

# Initialize Terraform
terraform init

# Review the plan (provide your subscription ID)
terraform plan -var="azure_subscription_id=YOUR_SUB_ID"

# Create resources
terraform apply -var="azure_subscription_id=YOUR_SUB_ID"

# Verify in Azure Portal or CLI
az group list --output table
az storage account list --resource-group terraform-demo-rg-dev

# Clean up
terraform destroy
```

See [azure-demo/README.md](azure-demo/README.md) for detailed instructions.

## 📁 Repository Structure

```
PythonProject16/
├── terraform_presentation.html    # Interactive presentation
├── README.md                       # This file
├── .gitignore                      # Git configuration
├── aws-demo/                       # AWS Terraform demo
│   ├── main.tf                     # AWS resource definitions
│   ├── variables.tf                # Input variables
│   ├── outputs.tf                  # Output values
│   └── README.md                   # Detailed AWS instructions
└── azure-demo/                     # Azure Terraform demo
    ├── main.tf                     # Azure resource definitions
    ├── variables.tf                # Input variables
    ├── outputs.tf                  # Output values
    └── README.md                   # Detailed Azure instructions
```

## 🔑 Key Terraform Commands

| Command | Purpose |
|---------|---------|
| `terraform init` | Initialize backend and download providers |
| `terraform plan` | Preview what will be created/modified/deleted |
| `terraform apply` | Execute the plan and create/modify resources |
| `terraform destroy` | Delete all resources managed by Terraform |
| `terraform fmt` | Format HCL code |
| `terraform validate` | Validate syntax |
| `terraform state list` | List resources in state |
| `terraform state show <resource>` | Show details of a resource |

## ⚙️ Configuration

### AWS Demo Customization

Create `aws-demo/terraform.tfvars`:
```hcl
aws_region         = "us-west-2"
vpc_cidr_block     = "10.1.0.0/16"
bucket_name        = "my-custom-bucket"
environment        = "prod"
```

### Azure Demo Customization

Create `azure-demo/terraform.tfvars`:
```hcl
azure_subscription_id = "your-subscription-id"
azure_location        = "West Europe"
resource_group_name   = "my-terraform-rg"
storage_account_name  = "mystorageaccount"
environment           = "prod"
```

## 🔒 State File Management

**Important:** Never commit state files to Git. The `.gitignore` file already excludes:
- `*.tfstate` and `*.tfstate.*` files
- `.terraform/` directories
- `*.tfvars` files

These files contain sensitive information and cloud credentials.

## 📊 Learning Outcomes

After going through this repository, you'll understand:

1. ✅ Why Infrastructure as Code is essential
2. ✅ How Terraform works and its architecture
3. ✅ How to write HCL code for resources
4. ✅ The Terraform workflow (init → plan → apply → destroy)
5. ✅ How to deploy actual infrastructure on AWS and Azure
6. ✅ State management best practices
7. ✅ How to scale Terraform for team collaboration

## 🛠 Troubleshooting

### General Issues

**Q: Terraform command not found**
```bash
which terraform
# If not found, install from terraform.io or use a package manager
brew install terraform  # macOS
```

**Q: State file issues**
```bash
# View current state
terraform state list

# View specific resource
terraform state show aws_vpc.main

# Import existing resource
terraform import aws_instance.example i-1234567890abcdef0
```

**Q: Provider authentication issues**

For AWS:
```bash
aws sts get-caller-identity
aws configure
```

For Azure:
```bash
az account show
az login
```

### Demo-Specific Issues

See:
- [aws-demo/README.md#Common Issues](aws-demo/README.md#common-issues)
- [azure-demo/README.md#Common Issues](azure-demo/README.md#common-issues)

## 📚 Additional Resources

- [Terraform Official Documentation](https://www.terraform.io/docs)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)
- [Terraform Best Practices](https://www.terraform.io/language)

## 🎓 Author

**Oleksandr Shynkarov**  
Data Engineer

