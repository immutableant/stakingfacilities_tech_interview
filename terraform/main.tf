provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "local" {}

module "vpc" {
  source     = "./vpc"
  stack_name = var.stack_name
}

module "subnet" {
  source     = "./subnet"
  vpc_id     = module.vpc.vpc_id
  stack_name = var.stack_name
  region     = var.region
}

module "internet_gateway" {
  source     = "./internet_gateway"
  vpc_id     = module.vpc.vpc_id
  stack_name = var.stack_name
}

module "security_group" {
  source     = "./security_group"
  vpc_id     = module.vpc.vpc_id
  stack_name = var.stack_name
  json_rpc_cidr_blocks = var.json_rpc_cidr_blocks
}

module "route_table" {
  source              = "./route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  subnet_a_id         = module.subnet.subnet_a_id
  subnet_b_id         = module.subnet.subnet_b_id
  stack_name          = var.stack_name
}

module "launch_template" {
  source            = "./launch_template"
  security_group_id = module.security_group.security_group_id
  stack_name        = var.stack_name
  key_pair_id       = module.key_pair.key_pair_id
}

module "key_pair" {
  source     = "./key_pair"
  stack_name = var.stack_name
}

module "instances" {
  source             = "./instances"
  launch_template_id = module.launch_template.launch_template_id
  subnet_a_id        = module.subnet.subnet_a_id
  subnet_b_id        = module.subnet.subnet_b_id
  stack_name         = var.stack_name
}

