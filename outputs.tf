output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.upload_bucket.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.upload_bucket.arn
}

output "bucket_region" {
  description = "Region of the created S3 bucket"
  value       = aws_s3_bucket.upload_bucket.region
}

output "bucket_domain_name" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.upload_bucket.bucket_domain_name
}

output "public_url_pattern" {
  description = "URL pattern for accessing objects (when public)"
  value       = var.make_private ? "Bucket is private" : "https://${aws_s3_bucket.upload_bucket.bucket_domain_name}/<object-key>"
}

output "is_public" {
  description = "Whether the bucket is publicly accessible"
  value       = !var.make_private
}