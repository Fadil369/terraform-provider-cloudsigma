variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use for subnets"
  type        = list(string)
  default     = []
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks to allow SSH access from"
  type        = string
  default     = "0.0.0.0/0"  # Note: In production, this should be restricted to specific IPs
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
