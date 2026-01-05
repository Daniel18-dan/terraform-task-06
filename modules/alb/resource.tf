resource "aws_lb" "this" {
  name               = "alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}
