variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the Security Group"
  type        = string
}

variable "key_pair_id" {
  description = "Key Name"
  type        = string
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-*-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_template" "lt" {
  name = format("%sLaunchTemplate", var.stack_name)

  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.xlarge"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 200
      delete_on_termination = true
      iops                  = 10000
      encrypted             = true
      volume_type           = "gp3"
      throughput            = 125
    }
  }

  key_name = var.key_pair_id

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(join("\n", [
    "#cloud-config",
    "output: {all: '| tee -a /var/log/cloud-init-output.log'}",
    "package_upgrade: true",
    "packages:",
    "  - acl"
  ]))

  tags = {
    Name = var.stack_name
  }
}

output "launch_template_id" {
  value = aws_launch_template.lt.id
}
