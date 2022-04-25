resource "aws_security_group" "ecsBasicService" {
  name        = "ecsBasicServiceSg"
  description = "Allow http,https traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "allow all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "ecsBasicServiceALB" {
  name        = "ecsBasicServiceALBSg"
  description = "Allow http,https traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow inbound all"
    from_port   = 1
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
