variable "aws_region" {
  description = "AWS region where the bucket will be created"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
}

variable "environment" {
  description = "Environment tag for the bucket"
  type        = string
  default     = "personal"
}

variable "make_private" {
  description = "Set to true to make the bucket private, false for public access"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}
