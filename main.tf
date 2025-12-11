terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# S3 Bucket
resource "aws_s3_bucket" "upload_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    ManagedBy   = "OpenTofu"
  }
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Public access block - toggles public/private
resource "aws_s3_bucket_public_access_block" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id

  block_public_acls       = var.make_private
  block_public_policy     = var.make_private
  ignore_public_acls      = var.make_private
  restrict_public_buckets = var.make_private
}

# Bucket ACL - only set to public-read when not private
resource "aws_s3_bucket_acl" "upload_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.upload_bucket,
    aws_s3_bucket_public_access_block.upload_bucket,
  ]

  bucket = aws_s3_bucket.upload_bucket.id
  acl    = var.make_private ? "private" : "public-read"
}

# Bucket policy for public read access (only when public)
resource "aws_s3_bucket_policy" "upload_bucket" {
  count  = var.make_private ? 0 : 1
  bucket = aws_s3_bucket.upload_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.upload_bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.upload_bucket]
}

# Optional: Enable versioning
resource "aws_s3_bucket_versioning" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}
