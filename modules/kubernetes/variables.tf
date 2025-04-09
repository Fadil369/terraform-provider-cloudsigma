variable "name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC (VLAN) where the cluster will be deployed"
  type        = string
}

variable "cluster_cidr" {
  description = "CIDR for the Kubernetes cluster network"
  type        = string
  default     = "10.0.0.0/24"
}

variable "node_count" {
  description = "Number of worker nodes in the cluster"
  type        = number
  default     = 3
}

variable "os_image_uuid" {
  description = "UUID of the OS image to use for the nodes"
  type        = string
}

variable "k3s_version" {
  description = "Version of K3s to install"
  type        = string
  default     = "v1.25.4+k3s1"
}

variable "control_plane_cpu" {
  description = "CPU allocation for the control plane node in MHz"
  type        = number
  default     = 2000 # 2 GHz
}

variable "control_plane_memory" {
  description = "Memory allocation for the control plane node in MB"
  type        = number
  default     = 4096 # 4 GB
}

variable "control_plane_smp" {
  description = "CPU cores for the control plane node"
  type        = number
  default     = 2
}

variable "worker_cpu" {
  description = "CPU allocation for worker nodes in MHz"
  type        = number
  default     = 2000 # 2 GHz
}

variable "worker_memory" {
  description = "Memory allocation for worker nodes in MB"
  type        = number
  default     = 4096 # 4 GB
}

variable "worker_smp" {
  description = "CPU cores for worker nodes"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
