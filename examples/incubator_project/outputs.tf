output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "kubernetes_cluster_endpoint" {
  description = "Endpoint for the Kubernetes API"
  value       = module.k3s_cluster.cluster_endpoint
  sensitive   = true
}

output "kubernetes_cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = module.k3s_cluster.cluster_name
}

output "database_endpoint" {
  description = "Endpoint for the database connection"
  value       = module.database.endpoint
  sensitive   = true
}

output "redis_endpoint" {
  description = "Endpoint for Redis connection"
  value       = module.redis.endpoint
  sensitive   = true
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = module.load_balancer.dns_name
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}
