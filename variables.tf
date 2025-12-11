variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
}

variable "block_public_access" {
  description = "Whether to block public access to the bucket. Set to false to make bucket contents publicly accessible."
  type        = bool
  default     = false
}
