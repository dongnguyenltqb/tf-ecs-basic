resource "aws_security_group" "svc" {
  name        = format("%s%sEcsServiceSg", var.cluster_name, var.be_service_name)
  description = "Allow http,https traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "allow be port"
    from_port       = var.be_container_port
    to_port         = var.be_container_port
    protocol        = "TCP"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
