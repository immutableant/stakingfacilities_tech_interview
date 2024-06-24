variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "subnet_a_id" {
  description = "The ID of Subnet A"
  type        = string
}

variable "subnet_b_id" {
  description = "The ID of Subnet B"
  type        = string
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.stack_name
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table_association" "a" {
  subnet_id      = var.subnet_a_id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = var.subnet_b_id
  route_table_id = aws_route_table.rt.id
}

output "route_table_id" {
  value = aws_route_table.rt.id
}
