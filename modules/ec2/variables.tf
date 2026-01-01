variable "ami_id" {
  description = "AMI ID used to launch the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (example: t2.micro)"
  type        = string
}

variable "environment" {
  description = "Environment name (DEV / QA / PROD)"
  type        = string
}

variable "owner" {
  description = "Owner of the resource"
  type        = string
}

variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
