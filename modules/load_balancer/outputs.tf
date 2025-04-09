output "id" {
  description = "ID of the load balancer server"
  value       = cloudsigma_server.load_balancer.id
}

output "name" {
  description = "Name of the load balancer"
  value       = cloudsigma_server.load_balancer.name
}

output "private_ip" {
  description = "Private IP address of the load balancer"
  value       = cloudsigma_server.load_balancer.network[0].ip_v4_conf[0].ip
}

output "public_ip" {
  description = "Public IP address of the load balancer (if allocated)"
  value       = var.allocate_public_ip ? cloudsigma_ip.load_balancer[0].ip : null
}

output "dns_name" {
  description = "DNS name for the load balancer (placeholder for actual DNS integration)"
  value       = var.domain_names != null && length(var.domain_names) > 0 ? var.domain_names[0] : var.allocate_public_ip ? "lb-${var.name}.example.com" : null
}

output "http_enabled" {
  description = "Whether HTTP is enabled on the load balancer"
  value       = var.enable_http
}

output "https_enabled" {
  description = "Whether HTTPS is enabled on the load balancer"
  value       = var.enable_https
}
