resource "aws_ecs_task_definition" "app" {
  family                   = var.task_definition_family
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.execution_task.arn
  container_definitions = jsonencode(
    [
      {
        "name" : var.container_name,
        "image" : var.image_url,
        "cpu" : 1024,
        "memory" : 2048,
        "portMappings" : [
          {
            "containerPort" : var.container_port,
            "protocol" : "http"
          }
        ],
        "essential" : true,
        "healthCheck" : {
          "command" : ["CMD-SHELL", format("curl -f http://localhost:%s/ || exit 1", var.container_port)],
          "interval" : 5,
          "timeout" : 5,
          "retries" : 2,
          "startPeriod" : 5
        }
      }
    ]
  )
}


resource "aws_ecs_task_definition" "app_ec2" {
  family                   = var.task_ec2_definition_family
  requires_compatibilities = ["EC2"]
  cpu                      = 1024
  memory                   = 2048
  network_mode             = "host"
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  execution_role_arn = aws_iam_role.execution_task.arn
  container_definitions = jsonencode(
    [
      {
        "name" : var.container_name,
        "image" : var.image_url,
        "cpu" : 1024,
        "memory" : 2048,
        "portMappings" : [
          {
            "containerPort" : var.container_port,
            "hostPort" : var.container_port,
            "protocol" : "tcp"
          }
        ],
        "essential" : true,
        "healthCheck" : {
          "command" : ["CMD-SHELL", format("curl -f http://localhost:%s/ || exit 1", var.container_port)],
          "interval" : 5,
          "timeout" : 5,
          "retries" : 2,
          "startPeriod" : 5
        }
      }
    ]
  )
}
