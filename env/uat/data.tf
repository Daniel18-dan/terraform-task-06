data "aws_subnet" "private" {
  filter {
    name   = "tag:Name"
    values = ["uat-private-subnet"]
  }
}
