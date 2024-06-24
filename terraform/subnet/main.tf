variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "region" {
  description = "AWS Region to deploy stack to"
  type        = string
}

resource "aws_subnet" "public_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%sPublicA", var.stack_name)
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%sPublicB", var.stack_name)
  }
}

output "subnet_a_id" {
  value = aws_subnet.public_a.id
}

output "subnet_b_id" {
  value = aws_subnet.public_b.id
}
