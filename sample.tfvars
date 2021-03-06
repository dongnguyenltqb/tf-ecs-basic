region             = "ap-southeast-1"
vpc_id             = "vpc-id"
subnets            = ["subnet-0464c", "subnet-dfb9", "subnet-f041"]
availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

cluster_name              = "x1"
fe_service_name           = "frontend-app"
be_service_name           = "backend-api"
fe_task_definition_family = "frontend-task-def"
be_task_definition_family = "backend-task-def"
container_name            = "nodejs"
image_url                 = "public.ecr.aws/g3k3o5v3/testport3000:latest"
fe_container_port         = 80
be_container_port         = 3000
secrets = {
  Username = "dongnguyenltqb"
  Password = "hello"
  Age      = "25"
  Role     = "admin"
}
