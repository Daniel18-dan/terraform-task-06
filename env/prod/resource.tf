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
