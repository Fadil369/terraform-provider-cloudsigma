variable "name" {
  description = "Name of the Redis instance"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC (VLAN) where Redis will be deployed"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_ids" {
  description = "List of subnet IDs where Redis can be placed"
  type        = list(string)
}

variable "redis_version" {
  description = "Version of Redis to install"
  type        = string
  default     = "6.2"
}

variable "redis_password" {
  description = "Password for Redis authentication (sensitive)"
  type        = string
  sensitive   = true
}

variable "os_image_uuid" {
  description = "UUID of the OS image to use for the Redis server"
  type        = string
}

variable "cpu" {
  description = "CPU allocation for the Redis server in MHz"
  type        = number
  default     = 1000 # 1 GHz
}

variable "memory" {
  description = "Memory allocation for the Redis server in MB"
  type        = number
  default     = 2048 # 2 GB
}

variable "smp" {
  description = "CPU cores for the Redis server"
  type        = number
  default     = 1
}

variable "storage_size" {
  description = "Size of the Redis storage in GB"
  type        = number
  default     = 10
}

variable "storage_mount_point" {
  description = "Mount point for Redis persistence storage"
  type        = string
  default     = "/var/lib/redis"
}

variable "maxmemory" {
  description = "Maximum memory Redis can use (e.g., '1gb')"
  type        = string
  default     = "1gb"
}

variable "maxmemory_policy" {
  description = "Redis eviction policy when maximum memory is reached"
  type        = string
  default     = "volatile-lru"
  
  validation {
    condition     = contains(["noeviction", "allkeys-lru", "volatile-lru", "allkeys-random", "volatile-random", "volatile-ttl"], var.maxmemory_policy)
    error_message = "Maxmemory policy must be one of: noeviction, allkeys-lru, volatile-lru, allkeys-random, volatile-random, volatile-ttl."
  }
}

variable "static_ip" {
  description = "Static IP to assign to the Redis instance (optional)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
