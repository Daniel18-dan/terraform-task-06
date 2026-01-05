resource "aws_security_group" "ec2_sg" {
  name   = "dev-ec2-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



module "ec2" {
  source = "../../modules/ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = data.aws_subnet.private.id
  security_group_ids = [aws_security_group.ec2_sg.id]

  environment = var.environment
  owner       = var.owner
  name        = "ec2-${var.environment}"
}
