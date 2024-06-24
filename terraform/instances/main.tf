variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "launch_template_id" {
  description = "The ID of the Launch Template"
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

resource "aws_instance" "instance_a" {
  subnet_id = var.subnet_a_id
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tags = {
    "Name" = format("%sInstanceA", var.stack_name)
  }
}

resource "aws_instance" "instance_b" {
  subnet_id = var.subnet_b_id
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tags = {
    "Name" = format("%sInstanceB", var.stack_name)
  }
}

output "instance_a_id" {
  value = aws_instance.instance_a.id
}

output "instance_b_id" {
  value = aws_instance.instance_b.id
}

output "instance_a_dns" {
  value = aws_instance.instance_a.public_dns
}

output "instance_b_dns" {
  value = aws_instance.instance_b.public_dns
}
