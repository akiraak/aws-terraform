resource "aws_lb" "main" {
  #count = var.enable_alb ? 1 : 0

  name = "${local.service_prefix}-main"

  internal           = false
  load_balancer_type = "application"

  /*
  access_logs {
    bucket  = data.terraform_remote_state.log_alb.outputs.s3_bucket_this_id
    enabled = true
    prefix  = "main"
  }*/
  access_logs {
    bucket  = aws_s3_bucket.log.bucket
    prefix  = "alb"
    enabled = true
  }

  security_groups = [
    aws_security_group.app_alb.id
    //data.terraform_remote_state.network_main.outputs.security_group_web_id,
    //data.terraform_remote_state.network_main.outputs.security_group_vpc_id
  ]

  /*
  subnets = [
    for s in data.terraform_remote_state.network_main.outputs.subnet_public : s.id
  ]
  */
  subnets = [
    aws_subnet.public_app_alb_1.id,
    aws_subnet.public_app_alb_2.id
  ]

  tags = {
    Name = "${local.service_prefix}-main"
  }
}

resource "aws_lb_listener" "https" {
  //count = var.enable_alb ? 1 : 0

  //certificate_arn   = aws_acm_certificate.root.arn
  certificate_arn   = local.acm_certificate_arn
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  #count = var.enable_alb ? 1 : 0

  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "main" {
  name = "${local.service_prefix}-main"

  deregistration_delay = 60
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  #vpc_id               = data.terraform_remote_state.network_main.outputs.vpc_this_id
  vpc_id               = aws_vpc.main.id

  health_check {
    healthy_threshold   = 2
    interval            = 30
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.service_prefix}-main"
  }
}