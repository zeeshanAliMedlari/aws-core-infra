data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

locals {
  subnets_by_az = {
    for index, cidr in var.private_subnet_cidrs :
    data.aws_availability_zones.available.names[index] => cidr
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name_prefix}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  for_each = local.subnets_by_az

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.name_prefix}-${each.key}-private"
    Environment = var.environment
    Network     = "private"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.name_prefix}-private"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]

  tags = {
    Name        = "${var.name_prefix}-s3"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "private" {
  bucket_prefix = "${var.name_prefix}-assets-"
  force_destroy = false

  tags = {
    Name        = "${var.name_prefix}-assets"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.private.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "private" {
  bucket = aws_s3_bucket.private.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "private" {
  bucket = aws_s3_bucket.private.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
