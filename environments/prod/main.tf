locals {
  environment = "prod"
  name_prefix = "aws-core-infra-prod"
}

module "core" {
  source = "../../modules/core"

  name_prefix          = local.name_prefix
  environment          = local.environment
  vpc_cidr             = "10.20.0.0/16"
  private_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
}
