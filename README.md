# upload-junk

OpenTofu configuration for creating a public/private S3 bucket for sharing files.

## Prerequisites

- [OpenTofu](https://opentofu.org/docs/intro/install/) installed locally
- AWS credentials configured (via `~/.aws/credentials`, environment variables, or AWS CLI)

## Quick Start

1. **Initialize OpenTofu:**
   ```bash
   tofu init
   ```

2. **Create your variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit `terraform.tfvars`** with your unique bucket name:
   ```hcl
   bucket_name = "your-unique-bucket-name"
   ```

4. **Preview the changes:**
   ```bash
   tofu plan
   ```

5. **Create the bucket:**
   ```bash
   tofu apply
   ```

## Toggle Public/Private

The bucket is **public by default**. To make it private:

**Option 1:** Update `terraform.tfvars`:
```hcl
make_private = true
```
Then run `tofu apply`.

**Option 2:** Override on the command line:
```bash
tofu apply -var="make_private=true"
```

To make it public again:
```bash
tofu apply -var="make_private=false"
```

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `bucket_name` | Globally unique S3 bucket name | (required) |
| `aws_region` | AWS region for the bucket | `us-east-1` |
| `make_private` | Set `true` to block public access | `false` |
| `enable_versioning` | Enable S3 versioning | `false` |
| `environment` | Environment tag | `personal` |

## Outputs

After applying, you'll see:
- `bucket_name` - The bucket name
- `bucket_domain_name` - The bucket's domain
- `public_url_pattern` - URL pattern for accessing files (when public)
- `is_public` - Whether the bucket is currently public

## Uploading Files

Once your bucket is created, upload files via AWS CLI:
```bash
aws s3 cp myfile.txt s3://your-bucket-name/
```

Access public files at:
```
https://your-bucket-name.s3.amazonaws.com/myfile.txt
```

## Destroy

To delete the bucket and all resources:
```bash
tofu destroy
```

> **Note:** The bucket must be empty before it can be destroyed.
