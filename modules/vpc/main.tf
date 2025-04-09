# VPC Module for BrainIncubator Platform
# This module creates a VPC with public and private subnets across multiple availability zones

locals {
  az_count = length(var.availability_zones) > 0 ? length(var.availability_zones) : 2
}

resource "cloudsigma_vlan" "this" {
  name        = var.name
  description = "VPC for ${var.name} in ${var.environment} environment"

  tags = var.tags
}

# Create public subnets
resource "cloudsigma_subnet" "public" {
  count = local.az_count

  name        = "${var.name}-public-${count.index + 1}"
  vlan_id     = cloudsigma_vlan.this.id
  cidr_block  = cidrsubnet(var.cidr_block, 4, count.index)
  public      = true

  tags = merge(var.tags, {
    Name        = "${var.name}-public-${count.index + 1}"
    Environment = var.environment
    Tier        = "public"
  })
}

# Create private subnets
resource "cloudsigma_subnet" "private" {
  count = local.az_count

  name        = "${var.name}-private-${count.index + 1}"
  vlan_id     = cloudsigma_vlan.this.id
  cidr_block  = cidrsubnet(var.cidr_block, 4, count.index + local.az_count)
  public      = false

  tags = merge(var.tags, {
    Name        = "${var.name}-private-${count.index + 1}"
    Environment = var.environment
    Tier        = "private"
  })
}

# Create firewall rules
resource "cloudsigma_firewall" "this" {
  name        = "${var.name}-firewall"
  description = "Firewall for ${var.name} VPC"

  # Allow internal traffic within the VPC
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.cidr_block
    protocol    = "all"
    description = "Allow internal traffic"
  }

  # Allow SSH access from specified CIDR blocks
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.ssh_cidr_blocks
    port_range  = "22"
    protocol    = "tcp"
    description = "Allow SSH access"
  }

  # Allow HTTP access
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = "0.0.0.0/0"
    port_range  = "80"
    protocol    = "tcp"
    description = "Allow HTTP access"
  }

  # Allow HTTPS access
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = "0.0.0.0/0"
    port_range  = "443"
    protocol    = "tcp"
    description = "Allow HTTPS access"
  }

  # Default deny all other inbound traffic
  rule {
    action      = "drop"
    direction   = "in"
    ip_range    = "0.0.0.0/0"
    protocol    = "all"
    description = "Deny all other inbound traffic"
  }

  # Allow all outbound traffic
  rule {
    action      = "accept"
    direction   = "out"
    ip_range    = "0.0.0.0/0"
    protocol    = "all"
    description = "Allow all outbound traffic"
  }

  tags = var.tags
}
