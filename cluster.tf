variable "cluster_name" {
  type = string
}
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE", aws_ecs_capacity_provider.ec2.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_capacity_provider" "ec2" {
  name = "ec2"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.group.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 50
    }
  }
}

resource "aws_launch_template" "ecs" {
  name_prefix            = "ecsInstanceTemplate"
  image_id               = var.ec2_image_id
  instance_type          = "t3.large"
  vpc_security_group_ids = [aws_security_group.ec2_group.id]
  monitoring {
    enabled = false
  }
  // block_device_mappings is for additional bock devices.
  // to change default setting 
  // we need to know device name for given ami
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 35
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "autoScaleGroup"
    }
  }
}

resource "aws_autoscaling_group" "group" {
  availability_zones    = var.availability_zones
  health_check_type     = "ELB"
  desired_capacity      = 0
  max_size              = 3
  min_size              = 0
  protect_from_scale_in = false
  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }
}
