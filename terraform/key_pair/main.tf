variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

resource "aws_key_pair" "kp" {
  key_name   = format("%sKey", var.stack_name)
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = var.stack_name
  }
}

output "key_pair_id" {
  value = aws_key_pair.kp.id
}
