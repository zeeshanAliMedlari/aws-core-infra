provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-core-infra"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}
