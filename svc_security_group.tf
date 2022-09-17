resource "aws_security_group" "svc" {
  name        = format("%s%sEcsServiceSecurityGroup", var.cluster_name, var.be_service_name)
  description = "Allow http,https traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow be port"
    from_port   = var.be_container_port
    to_port     = var.be_container_port
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags_all = merge(local.tags, var.tags, {
    Name = format("%s%sEcsServiceSecurityGroup", var.cluster_name, var.be_service_name)
  })
}
