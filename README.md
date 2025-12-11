# upload-junk
S3 IaC - Terraform configuration for creating a secure S3 bucket in AWS

## Overview

This repository contains Terraform code to create a secure S3 bucket in AWS. The bucket can be configured to allow public access for sharing files, or to block public access when needed.

## Features

- S3 bucket in the `us-east-1` region
- Configurable bucket name
- Toggleable public access control
- Server-side encryption enabled by default (AES256)
- Versioning enabled for data protection
- Public read policy (when public access is enabled)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0)
- AWS account with appropriate permissions
- AWS credentials configured (via AWS CLI, environment variables, or IAM role)

## Usage

### 1. Configure AWS Credentials

Ensure your AWS credentials are configured. You can do this by:

```bash
# Using AWS CLI
aws configure

# Or set environment variables
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
```

### 2. Set Up Variables

Copy the example variables file and customize it:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your desired values:

```hcl
bucket_name = "my-unique-bucket-name-12345"
block_public_access = false  # Set to true to block public access
```

**Note:** The bucket name must be globally unique across all AWS accounts.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan the Deployment

Review the changes that will be made:

```bash
terraform plan
```

### 5. Apply the Configuration

Create the S3 bucket:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 6. View Outputs

After successful deployment, Terraform will display outputs including:
- Bucket name
- Bucket ARN
- Bucket region
- Bucket domain name
- Public access status

## Changing Public Access

To toggle public access for your bucket:

1. Edit `terraform.tfvars`:
   - Set `block_public_access = false` for public access (default)
   - Set `block_public_access = true` to block all public access

2. Apply the changes:
   ```bash
   terraform apply
   ```

## Accessing Your Files

When public access is enabled (`block_public_access = false`):
- Upload files to your bucket via the AWS Console, AWS CLI, or other tools
- Files can be accessed via the URL pattern: `https://s3.amazonaws.com/your-bucket-name/file-name`

## Cleanup

To destroy the bucket and all resources:

```bash
terraform destroy
```

**Warning:** This will delete the bucket and all its contents. Make sure to back up any important data first.

## Security Considerations

- Server-side encryption is enabled by default for all objects
- Versioning is enabled to protect against accidental deletions
- Public access can be easily toggled on/off as needed
- Ensure your AWS credentials are kept secure and never committed to version control
