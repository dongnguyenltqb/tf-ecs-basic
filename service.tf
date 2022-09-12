// Service back-end api
resource "aws_ecs_service" "be" {
  depends_on = [
    aws_lb_target_group.be
  ]
  name                               = var.be_service_name
  cluster                            = aws_ecs_cluster.cluster.id
  task_definition                    = aws_ecs_task_definition.be.arn
  launch_type                        = "EC2"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 500
  force_new_deployment               = true
  wait_for_steady_state              = true
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.be.arn
    container_name   = var.container_name
    container_port   = var.be_container_port
  }
}
