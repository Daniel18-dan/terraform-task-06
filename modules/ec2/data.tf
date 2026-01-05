# Lookup default VPC
data "aws_vpc" "default" {
  default = true
}

# Lookup one subnet from default VPC
data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.default.id
}
