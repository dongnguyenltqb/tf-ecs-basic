variable "task_definition_family" {
  type = string
}
resource "aws_ecs_task_definition" "nextjs" {
  family                   = var.task_definition_family
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.basic_task_execution.arn
  container_definitions    = file("/Users/dong/Desktop/code/learn-iac/ecs-alb/task_definitions/nextjs_container_definition.json")
}
