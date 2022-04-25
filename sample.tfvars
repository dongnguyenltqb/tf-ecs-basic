vpc_id  = ""
subnets = ["", "", ""]

cluster_name           = "c1"
service_name           = "webapp"
task_definition_family = "reactjs"
container_name         = "reactjs"
image_url              = "public.ecr.aws/g3k3o5v3/testport3000"
container_port         = 3000
webapp_host            = "github.com"
