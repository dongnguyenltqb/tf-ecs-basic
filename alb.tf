resource "aws_lb" "svc" {
  name                       = "webapp"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.subnets
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "webapp" {
  name        = "ecsWebAppGroup"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "http" {
  port              = "80"
  load_balancer_arn = aws_lb.svc.arn
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = 403
      message_body = "403 ahihi"
    }
  }
}

resource "aws_lb_listener_rule" "http" {

  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
}
