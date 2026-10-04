output "vpc_id" {
  description = "ID of the prod VPC."
  value       = module.core.vpc_id
}

output "private_subnet_ids" {
  description = "IDs of the prod private subnets."
  value       = module.core.private_subnet_ids
}

output "s3_bucket_name" {
  description = "Name of the prod private S3 bucket."
  value       = module.core.s3_bucket_name
}

output "s3_vpc_endpoint_id" {
  description = "ID of the prod S3 gateway endpoint."
  value       = module.core.s3_vpc_endpoint_id
}
