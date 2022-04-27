resource "aws_ecs_service" "svc" {
  name                               = var.service_name
  cluster                            = aws_ecs_cluster.cluster.id
  task_definition                    = aws_ecs_task_definition.app.arn
  launch_type                        = "FARGATE"
  desired_count                      = 0
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  force_new_deployment               = true

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.svc.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.webapp.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_ecs_service" "svc2" {
  name                               = var.service_name_ec2
  cluster                            = aws_ecs_cluster.cluster.id
  task_definition                    = aws_ecs_task_definition.app_ec2.arn
  launch_type                        = "EC2"
  desired_count                      = 0
  deployment_minimum_healthy_percent = 0
  // roling update one by one
  deployment_maximum_percent = 100
  force_new_deployment       = true
}
