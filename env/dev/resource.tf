module "ec2" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  environment   = var.environment
  owner         = var.owner
  name          = "ec2-${var.environment}"
}
