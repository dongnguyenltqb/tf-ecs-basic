// Task role allows your Amazon ECS container task to make calls to other AWS services
resource "aws_iam_role" "task" {
  name = format("%sTaskRole", var.cluster_name)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags     = merge(local.tags, var.tags)
  tags_all = merge(local.tags, var.tags)
}
