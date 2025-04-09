# Redis Module for BrainIncubator Platform
# This module creates a Redis cache instance on CloudSigma

resource "cloudsigma_server" "redis" {
  name           = "${var.name}-redis"
  cpu            = var.cpu
  memory         = var.memory
  smp            = var.smp
  
  drive {
    uuid         = var.os_image_uuid
    boot_order   = 1
    dev_channel  = "ide"
    device       = "0:0"
  }
  
  # Add a data volume for Redis persistence
  drive {
    size         = var.storage_size
    boot_order   = 2
    dev_channel  = "virtio"
    device       = "1:0"
  }
  
  network {
    vlan_uuid = var.vpc_id
    ip_v4_conf {
      ip = var.static_ip != "" ? var.static_ip : null
      conf_type = var.static_ip != "" ? "static" : "dhcp"
    }
  }

  user_data = templatefile("${path.module}/templates/redis-init.tftpl", {
    redis_version = var.redis_version
    redis_password = var.redis_password
    storage_mount_point = var.storage_mount_point
    maxmemory = var.maxmemory
    maxmemory_policy = var.maxmemory_policy
  })

  tags = merge(var.tags, {
    "Service"    = "Cache"
    "Engine"     = "Redis"
    "Environment" = var.environment
  })
}

# Create a firewall rule for Redis
resource "cloudsigma_firewall" "redis" {
  name        = "${var.name}-redis-firewall"
  description = "Firewall for ${var.name} Redis cache"

  # Allow internal traffic from the VPC
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.vpc_cidr
    protocol    = "all"
    description = "Allow internal traffic from VPC"
  }

  # Allow Redis port access from the VPC
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.vpc_cidr
    port_range  = "6379"
    protocol    = "tcp"
    description = "Allow Redis port access"
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
