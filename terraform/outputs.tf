output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "subnet_a_id" {
  description = "Public Subnet A ID"
  value       = module.subnet.subnet_a_id
}

output "subnet_b_id" {
  description = "Public Subnet B ID"
  value       = module.subnet.subnet_a_id
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.launch_template.launch_template_id
}

output "key_pair_id" {
  description = "Key Name"
  value       = module.key_pair.key_pair_id
}

output "security_group_id" {
  description = "Security Group created"
  value       = module.security_group.security_group_id
}

output "instance_a_id" {
  description = "Instance A created"
  value       = module.instances.instance_a_id
}

output "instance_b_id" {
  description = "Instance B created"
  value       = module.instances.instance_b_id
}

output "instance_a_dns" {
  description = "Instance A DNS"
  value       = module.instances.instance_a_dns
}

output "instance_b_dns" {
  description = "Instance B DNS"
  value       = module.instances.instance_b_dns
}

resource "local_file" "hosts_ini" {
  content = <<EOF
[ethfullnodes]
instance_a ansible_host=${module.instances.instance_a_dns} ansible_user=ubuntu
instance_b ansible_host=${module.instances.instance_b_dns} ansible_user=ubuntu
EOF

  filename = "${path.module}/../ansible/inventory/hosts.ini"
}
