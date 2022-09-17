variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

variable "subnets" {
  type        = list(string)
  description = "require at least 2 subnets"
}

variable "cluster_name" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "be_service_name" {
  type = string
}

variable "be_task_definition_family" {
  type = string
}

variable "image_url" {
  type = string
}

variable "container_name" {
  type = string
}

variable "be_container_port" {
  type = number
}

variable "secrets" {
  type = map(string)
}
