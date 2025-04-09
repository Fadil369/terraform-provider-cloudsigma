variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC (VLAN) where the load balancer will be deployed"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the load balancer can be placed"
  type        = list(string)
}

variable "os_image_uuid" {
  description = "UUID of the OS image to use for the load balancer server"
  type        = string
}

variable "cpu" {
  description = "CPU allocation for the load balancer server in MHz"
  type        = number
  default     = 2000 # 2 GHz
}

variable "memory" {
  description = "Memory allocation for the load balancer server in MB"
  type        = number
  default     = 2048 # 2 GB
}

variable "smp" {
  description = "CPU cores for the load balancer server"
  type        = number
  default     = 2
}

variable "static_ip" {
  description = "Static IP to assign to the load balancer (optional)"
  type        = string
  default     = ""
}

variable "allocate_public_ip" {
  description = "Whether to allocate a public IP address for the load balancer"
  type        = bool
  default     = true
}

variable "enable_http" {
  description = "Whether to enable HTTP traffic (port 80)"
  type        = bool
  default     = true
}

variable "enable_https" {
  description = "Whether to enable HTTPS traffic (port 443)"
  type        = bool
  default     = true
}

variable "ssl_certificate" {
  description = "SSL certificate content for HTTPS (sensitive)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ssl_certificate_key" {
  description = "SSL certificate key for HTTPS (sensitive)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "domain_names" {
  description = "List of domain names for the load balancer"
  type        = list(string)
  default     = []
}

variable "target_groups" {
  description = "Map of target groups with their configuration"
  type        = map(object({
    port        = number
    protocol    = string
    targets     = optional(list(string), [])
    health_check = optional(object({
      path      = string
      port      = string
      interval  = optional(number, 30)
      timeout   = optional(number, 5)
      threshold = optional(number, 3)
    }))
  }))
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
