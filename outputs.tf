output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.upload_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.upload_bucket.arn
}

output "bucket_region" {
  description = "The AWS region where the bucket is located"
  value       = aws_s3_bucket.upload_bucket.region
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.upload_bucket.bucket_domain_name
}

output "public_access_enabled" {
  description = "Whether public access is enabled for the bucket"
  value       = !var.block_public_access
}
