# AWS Terraform Demo

This Terraform configuration deploys a complete VPC with public subnet and an S3 bucket on AWS.

## Prerequisites

1. **Terraform** installed (v1.0+)
   ```bash
   terraform --version
   ```

2. **AWS CLI** installed and configured
   ```bash
   aws --version
   aws configure
   ```

3. **AWS Account** with appropriate permissions to create:
   - VPC and subnets
   - Internet Gateway
   - Route tables
   - S3 buckets

## What Gets Created

This configuration creates the following AWS resources:

- **VPC** (10.0.0.0/16)
- **Public Subnet** (10.0.1.0/24)
- **Internet Gateway**
- **Route Table** with route to IGW
- **S3 Bucket** with versioning enabled and public access blocked

## Project Structure

```
aws-demo/
├── main.tf          # Main resource definitions
├── variables.tf     # Input variables with defaults
├── outputs.tf       # Output values
└── README.md        # This file
```

## Quick Start

### 1. Initialize Terraform

Download the required AWS provider and set up the local backend:

```bash
terraform init
```

### 2. Review the Plan

See what resources will be created:

```bash
terraform plan
```

You'll see something like:
```
+ aws_vpc.main
+ aws_internet_gateway.main
+ aws_subnet.public
+ aws_route_table.public
+ aws_route_table_association.public
+ aws_s3_bucket.demo
+ aws_s3_bucket_versioning.demo
+ aws_s3_bucket_public_access_block.demo
```

### 3. Apply the Configuration

Create the resources in AWS:

```bash
terraform apply
```

Terraform will ask for confirmation. Type `yes` to proceed.

### 4. View Outputs

After successful deployment, Terraform will display the created resource IDs:

```bash
Outputs:

vpc_id = "vpc-xxxxxxxxx"
vpc_cidr_block = "10.0.0.0/16"
public_subnet_id = "subnet-xxxxxxxxx"
s3_bucket_name = "terraform-demo-bucket-123456789012"
s3_bucket_arn = "arn:aws:s3:::terraform-demo-bucket-123456789012"
internet_gateway_id = "igw-xxxxxxxxx"
```

## Customization

To change the default values, you can:

### Option 1: Create a `terraform.tfvars` file

```hcl
aws_region          = "us-west-2"
vpc_cidr_block      = "10.1.0.0/16"
public_subnet_cidr  = "10.1.1.0/24"
bucket_name         = "my-custom-bucket"
project_name        = "my-project"
environment         = "prod"
```

Then apply:
```bash
terraform apply
```

### Option 2: Use command-line flags

```bash
terraform apply -var="aws_region=us-west-2" -var="environment=prod"
```

## Verify Deployment

### Check VPC in AWS Console:
1. Go to VPC Dashboard
2. Look for VPC with CIDR 10.0.0.0/16

### Check S3 Bucket:
1. Go to S3 Console
2. Look for bucket starting with `terraform-demo-bucket-`

### Check via AWS CLI:

```bash
# List VPCs
aws ec2 describe-vpcs --region us-east-1

# List S3 buckets
aws s3 ls

# Describe specific bucket
aws s3api head-bucket --bucket terraform-demo-bucket-123456789012
```

## Cleanup

To destroy all created resources:

```bash
terraform destroy
```

Terraform will show what will be deleted and ask for confirmation. Type `yes` to proceed.

**⚠️ Warning:** This will permanently delete the VPC, subnet, and S3 bucket.

## State Management

Terraform stores the state of your infrastructure in `terraform.tfstate`:

- ✅ This file is created locally
- ❌ **NEVER commit this to Git** (contains sensitive information)
- For team collaboration, use remote state (S3 + DynamoDB or Terraform Cloud)

## Common Issues

### Issue: "Access Denied" errors
**Solution:** Ensure your AWS credentials are correctly configured:
```bash
aws sts get-caller-identity
```

### Issue: S3 bucket name already exists
**Solution:** S3 bucket names are globally unique. Change the `bucket_name` variable:
```bash
terraform apply -var="bucket_name=my-unique-bucket-name"
```

### Issue: "Resource already exists"
**Solution:** Terraform state is out of sync. Check the state file and existing resources:
```bash
terraform state list
terraform state show aws_vpc.main
```

## Next Steps

1. **Add more resources:** Edit `main.tf` to add EC2 instances, databases, etc.
2. **Use modules:** Break code into reusable modules for larger projects
3. **Remote state:** Set up S3 backend for team collaboration
4. **CI/CD integration:** Use GitHub Actions or GitLab CI for automated deployments

## Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [S3 Best Practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/BestPractices.html)
- [Terraform State Documentation](https://www.terraform.io/language/state)

## Support

For issues or questions:
1. Check Terraform error messages carefully
2. Run `terraform plan` to see what will happen
3. Review CloudTrail logs in AWS Console for API errors
4. Check the [Terraform Registry](https://registry.terraform.io/) for provider docs

