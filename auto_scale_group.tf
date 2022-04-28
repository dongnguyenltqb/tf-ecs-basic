resource "aws_launch_template" "ecs" {
  name_prefix            = "ecsInstanceTemplate"
  image_id               = var.ec2_image_id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.ec2_group.id]
  user_data = base64encode(format(<<EOT
  #!/bin/bash
  echo ECS_CLUSTER=%s >> /etc/ecs/ecs.config
EOT
  , var.cluster_name))
  iam_instance_profile {
    // only use name or arn
    # name = aws_iam_instance_profile.ecs.name
    arn = aws_iam_instance_profile.ecs.arn
  }
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
      Name = format("autoScaleGroup %s", var.cluster_name)
    }
  }
}

resource "aws_autoscaling_group" "group" {
  availability_zones    = var.availability_zones
  health_check_type     = "ELB"
  desired_capacity      = 1
  max_size              = 5
  min_size              = 1
  protect_from_scale_in = true
  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }
}
