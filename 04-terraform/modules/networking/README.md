# Multi-Tier VPC - Terraform Configuration

This repository deploys a secure, production-grade multi-tier VPC on AWS using native Terraform resources.

## Architecture Overview

- **VPC** with customizable CIDR
- **Multi-AZ deployment** (default: 3 AZs) for high availability
- **Public subnets** (for ALBs, NAT Gateways)
- **Private subnets** (for application/database instances)
- **NAT Gateways** (configurable: one per AZ or single)
- **Internet Gateway** for public subnet outbound access
- **VPC Flow Logs** enabled (CloudWatch Logs, 90-day retention)
- **Security Groups** enforcing least privilege

## Security Best Practices (DevSecOps 2026 Standards)

- **No bastion hosts**
- **No exposed SSH/RDP ports**
- **Access exclusively via AWS Systems Manager (SSM) Session Manager**
  - Fully audited, no open inbound ports
  - Zero-trust compliant
- Security group for private instances has **no ingress rules**
- Dedicated IAM role + instance profile with `AmazonSSMManagedInstanceCore` policy

## Outputs

- VPC ID
- Public and private subnet IDs
- NAT Gateway public IPs
- Security group IDs (ALB, SSM-only private instances)
- SSM IAM instance profile

## Usage

```bash
module "multi_tier_vpc" {
  source = "./modules/networking"

  aws_region               = "us-east-1"
  environment              = "prod"
  vpc_cidr_block           = "10.0.0.0/16"
  availability_zone_count  = 3
  nat_gateway_strategy     = "one_per_az"
  flow_logs_enabled        = true
  flow_logs_retention_days = 90
}

```

- How to reference its outputs:
```bash
vpc_id              = module.multi_tier_vpc.vpc_id
public_subnet_ids   = module.multi_tier_vpc.public_subnet_ids
private_subnet_ids  = module.multi_tier_vpc.private_subnet_ids
private_instances_sg_id = module.multi_tier_vpc.private_instances_sg_id
```
