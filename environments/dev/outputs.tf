output "vpc_id" {
  description = "ID of the dev VPC."
  value       = module.core.vpc_id
}

output "private_subnet_ids" {
  description = "IDs of the dev private subnets."
  value       = module.core.private_subnet_ids
}

output "s3_bucket_name" {
  description = "Name of the dev private S3 bucket."
  value       = module.core.s3_bucket_name
}

output "s3_vpc_endpoint_id" {
  description = "ID of the dev S3 gateway endpoint."
  value       = module.core.s3_vpc_endpoint_id
}
