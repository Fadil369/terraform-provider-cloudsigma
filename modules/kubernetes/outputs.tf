output "cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = var.name
}

output "cluster_endpoint" {
  description = "Endpoint for the Kubernetes API"
  value       = "https://${cloudsigma_server.control_plane.network[0].ip_v4_conf[0].ip}:6443"
}

output "control_plane_ip" {
  description = "IP address of the control plane node"
  value       = cloudsigma_server.control_plane.network[0].ip_v4_conf[0].ip
}

output "worker_ips" {
  description = "IP addresses of the worker nodes"
  value       = [for node in cloudsigma_server.worker_nodes : node.network[0].ip_v4_conf[0].ip]
}

output "kubeconfig" {
  description = "Kubeconfig for accessing the cluster (sensitive)"
  value       = "To retrieve kubeconfig, SSH into the control plane node at ${cloudsigma_server.control_plane.network[0].ip_v4_conf[0].ip} and run: sudo cat /etc/rancher/k3s/k3s.yaml"
  sensitive   = true
}

output "node_token" {
  description = "Node token for joining the cluster (sensitive)"
  value       = random_string.node_token.result
  sensitive   = true
}
