resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg-dev"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}

module "ec2" {
  source        = "../../modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  environment   = var.environment
  owner         = var.owner
  name          = "task6-ec2"
}
