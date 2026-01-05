resource "aws_security_group" "ec2_sg" {
  name   = "uat-ec2-sg"
  vpc_id = data.aws_vpc.default.id
}
