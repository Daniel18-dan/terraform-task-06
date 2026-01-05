resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = data.aws_subnet.selected.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = var.name
    Environment = var.environment
    Owner       = var.owner
  }
}
