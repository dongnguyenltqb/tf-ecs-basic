region             = "ap-southeast-1"
vpc_id             = ""
subnets            = ["", "", ""]
availability_zones = ["", "", ""]

cluster_name               = "t2"
service_name               = "webapp"
service_name_ec2           = "webapp_ec2"
ec2_image_id               = "ami-095997bc097212f6f"
task_definition_family     = "reactjs"
task_ec2_definition_family = "reactjs_ec2"
container_name             = "reactjs"
image_url                  = ""
container_port             = 3000
webapp_host                = "github.com"
