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
