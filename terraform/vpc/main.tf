variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = var.stack_name
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}
