output "vpc_id" {
  description = "ID of the VPC created by this module."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets, one per availability zone."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets, one per availability zone."
  value       = aws_subnet.private[*].id
}

output "nat_public_ips" {
  description = "Public IP addresses of the NAT gateways."
  value       = aws_eip.nat[*].public_ip
}

output "public_alb_sg_id" {
  description = "Security group ID for the public Application Load Balancer."
  value       = aws_security_group.public_alb.id
}

output "ssm_sg_id" {
  description = "Security group ID used for SSM-related access (if attached)."
  value       = aws_security_group.ssm.id
}

output "private_instances_sg_id" {
  description = "Security group ID for private instances (no inbound; SSM-only outbound)."
  value       = aws_security_group.private_instances.id
}

output "ssm_instance_role_arn" {
  description = "IAM role ARN to attach to EC2 instances for SSM access."
  value       = aws_iam_role.ssm_instance_role.arn
}

output "ssm_instance_profile_name" {
  description = "Instance profile name to use in EC2 launch templates/configurations for SSM."
  value       = aws_iam_instance_profile.ssm_instance_profile.name
}
