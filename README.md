# AWS Core Infrastructure with Terraform

A small Terraform example with separate `dev` and `prod` states. Both environments use the shared module in `modules/core` to create:

- One VPC with two private subnets in separate available Availability Zones.
- An S3 gateway VPC endpoint, so resources in those subnets can reach S3 without a NAT gateway or internet gateway.
- A private S3 bucket with server-side encryption, bucket-owner enforced object ownership, and all S3 public access blocked.

There are no EC2 instances, NAT gateways, or internet gateways in this starter. The S3 bucket starts empty. The VPC and S3 gateway endpoint have no additional hourly charge; S3 storage, requests, and data transfer can still incur charges as you use the bucket.

## Prerequisites

- Terraform CLI 1.5 or newer.
- AWS CLI configured with credentials for the account where you want to create resources. Terraform uses the standard AWS credential chain, such as `AWS_PROFILE` or environment credentials; credentials are not stored in this repository.
- An AWS identity allowed to manage VPC resources, S3 buckets, and S3 VPC endpoints.

## Plan and apply dev

From the repository root:

```sh
export AWS_PROFILE=your-aws-profile
cd environments/dev
terraform init
terraform plan
terraform apply
```

Review the plan before applying. Terraform stores state locally in each environment directory; do not commit state files. For team use, configure a secured remote backend before sharing or running this configuration collaboratively.

To inspect the created resource IDs and bucket name:

```sh
terraform output
```

## Plan and apply prod

Use a separate shell or return to the repository root, then run:

```sh
export AWS_PROFILE=your-aws-profile
cd environments/prod
terraform init
terraform plan
terraform apply
```

Dev and prod have separate local Terraform state and non-overlapping VPC address ranges. Change `aws_region` in `variables.tf` (or pass `-var="aws_region=..."`) to use another AWS Region.

## Tear down

From the environment directory you want to remove:

```sh
terraform destroy
```

Terraform will not delete the S3 bucket if it contains objects. Empty it first, then run destroy again.
