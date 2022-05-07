// the task execution role that the Amazon ECS container agent and the Docker daemon can assume.
resource "aws_iam_role" "execution_task" {
  name = "ecsExcutionTaskRole"
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
}

resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy_execution_task_attachment" {
  role       = aws_iam_role.execution_task.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

// the instance role help ec2 instance register itself to ecs cluster
resource "aws_iam_role" "ec2_instances" {
  name = "ecsInstanceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerServiceforEC2Role_attachment" {
  role       = aws_iam_role.ec2_instances.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs" {
  name = format("ecsInstanceProfileRoleFor%s", var.cluster_name)
  role = aws_iam_role.ec2_instances.name
}


// allows your Amazon ECS container task to make calls to other AWS services
resource "aws_iam_role" "task" {
  name = "ecs_task_role"
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
}

resource "aws_iam_policy" "task_policy" {
  name = "task_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "task_policy_attachment" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.task_policy.arn
}


// In case container image is share from another account
// we need create a resource policy for ecr repository
// change action to your usecase
# resource "aws_ecr_repository_policy" "foopolicy" {
#   repository = "name_of_repository"
#   policy = jsonencode(
#     {
#       "Version" : "2008-10-17",
#       "Statement" : [
#         {
#           "Sid" : "new policy",
#           "Effect" : "Allow",
#           "Principal" : {
#             "AWS" : aws_iam_role.execution_task.arn
#           }
#           "Action" : [
#             "ecr:GetDownloadUrlForLayer",
#             "ecr:BatchGetImage",
#             "ecr:BatchCheckLayerAvailability",
#             "ecr:PutImage",
#             "ecr:InitiateLayerUpload",
#             "ecr:UploadLayerPart",
#             "ecr:CompleteLayerUpload",
#             "ecr:DescribeRepositories",
#             "ecr:GetRepositoryPolicy",
#             "ecr:ListImages",
#             "ecr:DeleteRepository",
#             "ecr:BatchDeleteImage",
#             "ecr:SetRepositoryPolicy",
#             "ecr:DeleteRepositoryPolicy"
#           ]
#         }
#       ]
#   })
# }
