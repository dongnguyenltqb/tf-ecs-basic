variable "cluster_name" {
  type = string
}
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = aws_ecs_cluster.cluster.name

  # capacity_providers = ["FARGATE"]
  capacity_providers = ["FARGATE", aws_ecs_capacity_provider.ec2.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_capacity_provider" "ec2" {
  name = "ec2_t1"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.group.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 10
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}
