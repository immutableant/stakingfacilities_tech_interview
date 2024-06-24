variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.stack_name
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
