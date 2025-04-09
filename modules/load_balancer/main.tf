# Load Balancer Module for BrainIncubator Platform
# This module creates a load balancer instance with NGINX on CloudSigma

resource "cloudsigma_server" "load_balancer" {
  name           = "${var.name}-lb"
  cpu            = var.cpu
  memory         = var.memory
  smp            = var.smp
  
  drive {
    uuid         = var.os_image_uuid
    boot_order   = 1
    dev_channel  = "ide"
    device       = "0:0"
  }
  
  network {
    vlan_uuid = var.vpc_id
    ip_v4_conf {
      ip = var.static_ip != "" ? var.static_ip : null
      conf_type = var.static_ip != "" ? "static" : "dhcp"
    }
  }

  user_data = templatefile("${path.module}/templates/nginx-init.tftpl", {
    target_groups = var.target_groups
    ssl_certificate = var.ssl_certificate
    ssl_certificate_key = var.ssl_certificate_key
    enable_https = var.enable_https
    enable_http = var.enable_http
    domain_names = var.domain_names
  })

  tags = merge(var.tags, {
    "Service"    = "LoadBalancer"
    "Type"       = "NGINX"
    "Environment" = var.environment
  })
}

# Create a public IP if requested
resource "cloudsigma_ip" "load_balancer" {
  count = var.allocate_public_ip ? 1 : 0
  
  server_uuid = cloudsigma_server.load_balancer.id
}

# Create a firewall rule for the load balancer
resource "cloudsigma_firewall" "load_balancer" {
  name        = "${var.name}-lb-firewall"
  description = "Firewall for ${var.name} load balancer"

  # Allow internal traffic from the VPC
  rule {
    action      = "accept"
    direction   = "in"
    ip_range    = var.vpc_cidr
    protocol    = "all"
    description = "Allow internal traffic from VPC"
  }

  # Allow HTTP access if enabled
  dynamic "rule" {
    for_each = var.enable_http ? [1] : []
    content {
      action      = "accept"
      direction   = "in"
      ip_range    = "0.0.0.0/0"
      port_range  = "80"
      protocol    = "tcp"
      description = "Allow HTTP access"
    }
  }

  # Allow HTTPS access if enabled
  dynamic "rule" {
    for_each = var.enable_https ? [1] : []
    content {
      action      = "accept"
      direction   = "in"
      ip_range    = "0.0.0.0/0"
      port_range  = "443"
      protocol    = "tcp"
      description = "Allow HTTPS access"
    }
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
