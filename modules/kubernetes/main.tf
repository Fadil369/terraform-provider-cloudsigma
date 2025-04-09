# Kubernetes Module for BrainIncubator Platform
# This module creates a K3s Kubernetes cluster on CloudSigma

resource "cloudsigma_server" "control_plane" {
  name           = "${var.name}-control-plane"
  cpu            = var.control_plane_cpu
  memory         = var.control_plane_memory
  smp            = var.control_plane_smp
  
  drive {
    uuid         = var.os_image_uuid
    boot_order   = 1
    dev_channel  = "ide"
    device       = "0:0"
  }
  
  network {
    vlan_uuid = var.vpc_id
    ip_v4_conf {
      ip = cidrhost(var.cluster_cidr, 10)
      conf_type = "static"
      netmask = split("/", var.cluster_cidr)[1]
    }
  }

  user_data = templatefile("${path.module}/templates/k3s-control-plane.tftpl", {
    k3s_version = var.k3s_version
    node_token  = random_string.node_token.result
    cluster_cidr = var.cluster_cidr
  })

  tags = merge(var.tags, {
    "kubernetes.io/role" = "control-plane"
    "Environment" = var.environment
    "Component"   = "K3s"
  })
}

resource "cloudsigma_server" "worker_nodes" {
  count          = var.node_count

  name           = "${var.name}-worker-${count.index + 1}"
  cpu            = var.worker_cpu
  memory         = var.worker_memory
  smp            = var.worker_smp
  
  drive {
    uuid         = var.os_image_uuid
    boot_order   = 1
    dev_channel  = "ide"
    device       = "0:0"
  }
  
  network {
    vlan_uuid = var.vpc_id
    ip_v4_conf {
      ip = cidrhost(var.cluster_cidr, 20 + count.index)
      conf_type = "static"
      netmask = split("/", var.cluster_cidr)[1]
    }
  }
  
  user_data = templatefile("${path.module}/templates/k3s-worker.tftpl", {
    k3s_version   = var.k3s_version
    node_token    = random_string.node_token.result
    control_plane_ip = cloudsigma_server.control_plane.network[0].ip_v4_conf[0].ip
    node_labels   = "kubernetes.io/role=worker"
  })

  tags = merge(var.tags, {
    "kubernetes.io/role" = "worker"
    "Environment" = var.environment
    "Component"   = "K3s"
  })
}

resource "random_string" "node_token" {
  length  = 64
  special = false
}
