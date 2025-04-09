variable "name" {
  description = "Name of the database instance"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC (VLAN) where the database will be deployed"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the database can be placed"
  type        = list(string)
}

variable "engine" {
  description = "Database engine type (postgresql, mysql, mongodb)"
  type        = string
  default     = "postgresql"
  
  validation {
    condition     = contains(["postgresql", "mysql", "mongodb"], var.engine)
    error_message = "Engine must be one of: postgresql, mysql, mongodb."
  }
}

variable "engine_version" {
  description = "Version of the database engine"
  type        = string
  default     = "13"
}

variable "os_image_uuid" {
  description = "UUID of the OS image to use for the database server"
  type        = string
}

variable "cpu" {
  description = "CPU allocation for the database server in MHz"
  type        = number
  default     = 2000 # 2 GHz
}

variable "memory" {
  description = "Memory allocation for the database server in MB"
  type        = number
  default     = 4096 # 4 GB
}

variable "smp" {
  description = "CPU cores for the database server"
  type        = number
  default     = 2
}

variable "storage_size" {
  description = "Size of the database storage in GB"
  type        = number
  default     = 50
}

variable "storage_mount_point" {
  description = "Mount point for the database storage"
  type        = string
  default     = "/var/lib/postgresql/data"
}

variable "db_name" {
  description = "Name of the default database to create"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Username for the database"
  type        = string
  default     = "dbuser"
}

variable "db_password" {
  description = "Password for the database (sensitive)"
  type        = string
  sensitive   = true
}

variable "static_ip" {
  description = "Static IP to assign to the database instance (optional)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
