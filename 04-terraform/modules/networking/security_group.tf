
###############
# Security groups
###############

resource "aws_security_group" "public_alb" {
  name        = "public-alb-sg-${var.environment}"
  description = "Allow HTTP/HTTPS for public ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "public-alb-sg-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "private_instances" {
  name        = "private-instances-sg-${var.environment}"
  description = "No inbound access; outbound only for required traffic and SSM"
  vpc_id      = aws_vpc.main.id

  # SSM and related AWS services via prefix lists
  egress {
    description     = "Allow instances to reach SSM and related AWS endpoints"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = data.aws_prefix_lists.ssm_prefix_lists[*].id
  }

  # HTTP egress for updates
  egress {
    description = "Allow instances to download patches and updates"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "private-instances-sg-${var.environment}"
    Environment = var.environment
  }
}
