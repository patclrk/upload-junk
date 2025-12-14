# upload-junk

Because sometimes you need to upload junk, then share that junk with other people.

This repo contains IaC to manage an S3 bucket so you can avoid the $0.03 monthly AWS bill because you keep forgetting to delete that bucket you created a year ago because you're too lazy to click around the AWS console.


## Prerequisites

- [OpenTofu](https://opentofu.org/docs/intro/install/) installed locally
- AWS credentials configured
- Optional: create an IAM user and policy for bucket operations (see `policy.json`)

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

1. Update `terraform.tfvars`:

   ```hcl
   make_private = true
   ```
2. Then run `tofu apply`.

#### Create presigned URL
You can share junk via presigned URLs in private buckets (default 1 hour)
```bash
aws s3 presign s3://your-bucket-name/yourfile.txt --profile upload-junk
```

## Uploading Files

Via AWS CLI:
```bash
aws s3 cp myfile.txt s3://your-bucket-name/
```

Access public files at:
```
https://your-bucket-name.s3.amazonaws.com/yourfile.txt
```

## Destroy

First, delete everything in the bucket:
```bash
aws s3 rm s3://your-bucket-name --recursive --profile upload-junk
```
If you enabled versioning:
```bash
aws s3api delete-objects \
  --bucket your-bucket-name \
  --delete "$(aws s3api list-object-versions \
    --bucket your-bucket-name \
    --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}' \
    --output json)" \
  --profile upload-junk
```

Delete the bucket:
```bash
tofu destroy
```
