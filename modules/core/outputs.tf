output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs of the two private subnets."
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "s3_bucket_name" {
  description = "Name of the private S3 bucket."
  value       = aws_s3_bucket.private.id
}

output "s3_bucket_arn" {
  description = "ARN of the private S3 bucket."
  value       = aws_s3_bucket.private.arn
}

output "s3_vpc_endpoint_id" {
  description = "ID of the S3 gateway VPC endpoint."
  value       = aws_vpc_endpoint.s3.id
}
