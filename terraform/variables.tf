variable "stack_name" {
  description = "Name of the stack"
  type        = string
  default     = "EthereumFullNodeStack"
}

variable "region" {
  description = "AWS Region to deploy stack to"
  type        = string
  default     = "us-west-2"
}

variable "json_rpc_cidr_blocks" {
  description = "The CIDR blocks for JSON-RPC interface"
  type        = list(string)
  default     = ["0.0.0.0/0"] # default to allow all traffic for exercise purposes, this should be 
}