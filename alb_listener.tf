// listener response 404 by default
resource "aws_lb_listener" "http" {
  port              = "80"
  load_balancer_arn = aws_lb.svc.arn
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = 404
      message_body = "there is nothing here"
    }
  }
}

resource "aws_lb_listener_rule" "be" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.be.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

