# Database Module for BrainIncubator Platform
# This module creates a managed PostgreSQL database on CloudSigma

resource "cloudsigma_server" "database" {
  name           = "${var.name}-${var.engine}"
  cpu            = var.cpu
  memory         = var.memory
  smp            = var.smp
  
  drive {
    uuid         = var.os_image_uuid
    boot_order   = 1
    dev_channel  = "ide"
    device       = "0:0"
  }
  
  # Add a data volume for the database
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

  user_data = templatefile("${path.module}/templates/${var.engine}-init.tftpl", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    engine_version = var.engine_version
    storage_mount_point = var.storage_mount_point
  })

  tags = merge(var.tags, {
    "Service"    = "Database"
    "Engine"     = var.engine
    "Environment" = var.environment
  })
}

# Create a firewall rule for the database
resource "cloudsigma_firewall" "database" {
  name        = "${var.name}-${var.engine}-firewall"
  description = "Firewall for ${var.name} database"

  # Allow internal traffic from the VPC
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.vpc_cidr
    protocol    = "all"
    description = "Allow internal traffic from VPC"
  }

  # Allow database port access from the VPC
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.vpc_cidr
    port_range  = var.engine == "postgresql" ? "5432" : (var.engine == "mysql" ? "3306" : "27017")
    protocol    = "tcp"
    description = "Allow database port access"
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
