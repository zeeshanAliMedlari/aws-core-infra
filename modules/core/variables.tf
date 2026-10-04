variable "name_prefix" {
  description = "Lowercase prefix used for resource names and the S3 bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name_prefix)) && length(var.name_prefix) <= 29
    error_message = "name_prefix must contain only lowercase letters, numbers, or hyphens and be at most 29 characters long."
  }
}

variable "environment" {
  description = "Environment name applied to resource tags."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR range for the VPC."
  type        = string
}

variable "private_subnet_cidrs" {
  description = "Exactly two non-overlapping IPv4 CIDR ranges, one for each private subnet."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDR ranges."
  }
}
