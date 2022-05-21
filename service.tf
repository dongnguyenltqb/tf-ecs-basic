# resource "aws_ecs_service" "fe" {
#   name                               = var.fe_service_name
#   cluster                            = aws_ecs_cluster.cluster.id
#   task_definition                    = aws_ecs_task_definition.fe.arn
#   launch_type                        = "FARGATE"
#   desired_count                      = 1
#   deployment_minimum_healthy_percent = 0
#   deployment_maximum_percent         = 100
#   force_new_deployment               = true

#   network_configuration {
#     subnets          = var.subnets
#     assign_public_ip = false
#     security_groups  = [aws_security_group.svc.id]
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.fe.arn
#     container_name   = var.container_name
#     container_port   = var.container_port
#   }
# }

resource "aws_ecs_service" "be" {
  depends_on = [
    aws_lb_target_group.be
  ]
  name                               = var.be_service_name
  cluster                            = aws_ecs_cluster.cluster.id
  task_definition                    = aws_ecs_task_definition.be.arn
  launch_type                        = "EC2"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 500

  force_new_deployment  = true
  wait_for_steady_state = true

  load_balancer {
    target_group_arn = aws_lb_target_group.be.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
