// back end target group
resource "aws_lb_target_group" "be" {
  depends_on = [
    aws_lb.svc
  ]
  name        = format("%s-be-target-group", aws_lb.svc.name)
  port        = var.be_container_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    enabled  = true
    path     = "/"
    port     = var.be_container_port
    protocol = "HTTP"
    matcher  = "200,404"
  }
}
