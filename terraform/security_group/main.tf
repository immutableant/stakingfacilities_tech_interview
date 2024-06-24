variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "json_rpc_cidr_blocks" {
  description = "The CIDR blocks for JSON-RPC interface"
  type        = list(string)
}

resource "aws_security_group" "sg" {
  vpc_id      = var.vpc_id
  description = "Allow SSH and custom port 4001 TCP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow traffic for JSON-RPC interface (for exercise purposes)
  ingress {
    from_port   = 8545
    to_port     = 8545
    protocol    = "tcp"
    cidr_blocks = var.json_rpc_cidr_blocks
  }

  # Allow traffic to TCP port 30303 for P2P communication
  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow traffic to UDP port 30303 for P2P communication and node discovery
  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow traffic to TCP port 9000 for Nimbus
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow traffic to UDP port 9000 for Nimbus
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.stack_name
  }
}

output "security_group_id" {
  value = aws_security_group.sg.id
}
