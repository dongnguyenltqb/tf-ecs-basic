variable "service_name" {
  type = string
}

resource "aws_ecs_service" "basic" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.basic.id
  task_definition = aws_ecs_task_definition.nextjs.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.ecsBasicService.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.webapp.arn
    container_name   = "nextjs80"
    container_port   = 80
  }
}
