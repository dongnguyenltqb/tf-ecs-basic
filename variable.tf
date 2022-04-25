variable "region" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "service_name" {
  type = string
}

variable "service_name_ec2" {
  type = string
}

variable "task_definition_family" {
  type = string
}

variable "task_ec2_definition_family" {
  type = string
}

variable "image_url" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}

// Check ami here
// https://docs.amazonaws.cn/en_us/AmazonECS/latest/developerguide/ecs-ami-versions.html
variable "ec2_image_id" {
  type = string
}

variable "webapp_host" {
  type = string
}
