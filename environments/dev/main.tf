locals {
  environment = "dev"
  name_prefix = "aws-core-infra-dev"
}

module "core" {
  source = "../../modules/core"

  name_prefix          = local.name_prefix
  environment          = local.environment
  vpc_cidr             = "10.10.0.0/16"
  private_subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
}
