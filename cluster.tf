variable "cluster_name" {
  type = string
}
resource "aws_ecs_cluster" "basic" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "basic" {
  cluster_name = aws_ecs_cluster.basic.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
