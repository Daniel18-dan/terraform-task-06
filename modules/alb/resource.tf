resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"

  tags = {
    Environment = var.environment
  }
}
