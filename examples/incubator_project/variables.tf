variable "project_name" {
  description = "Name of the BrainIncubator project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "kubernetes_node_count" {
  description = "Number of nodes in the Kubernetes cluster"
  type        = number
  default     = 3
}

variable "kubernetes_instance_type" {
  description = "Instance type for Kubernetes nodes"
  type        = string
  default     = "medium"
}

variable "db_instance_type" {
  description = "Instance type for database"
  type        = string
  default     = "medium"
}

variable "certificate_arn" {
  description = "ARN of the TLS certificate for the load balancer"
  type        = string
  default     = null
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Platform    = "BrainIncubator"
  }
}
