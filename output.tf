output "alb_dns_name" {
  value = aws_lb.svc.dns_name
}
output "task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}

output "image_url" {
  value = var.image_url
}


output "execution_task_role_arn" {
  value = aws_iam_role.execution_task.arn
}
