resource "aws.cluster" "this" {
  name = var.cluster_name


  setting {
    name  = "containerInsights"
    value = var.cloudwatch_custom_metrics_enabled ? "enabled" : "disabled"
  }

  # Production tags
  tags = merge(var.tags, {
    Name        = var.cluster_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}

resource "aws.cluster_capacity_providers" "this" {
  cluster_name = aws.cluster.this.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 1
    capacity_provider = "FARGATE_SPOT"
  }
}

resource "aws.task_definition" "this" {
  family                   = var.task_family
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      environment = var.container_env
    }
  ])
}

resource "aws.service" "this" {
  name            = var.service_name
  cluster         = aws.cluster.this.id
  task_definition = aws.task_definition.this
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  deployment_controller {
    type = "BLUE_GREEN"
  }
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}
