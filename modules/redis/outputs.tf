output "id" {
  description = "ID of the Redis server"
  value       = cloudsigma_server.redis.id
}

output "name" {
  description = "Name of the Redis server"
  value       = cloudsigma_server.redis.name
}

output "endpoint" {
  description = "Connection endpoint for Redis"
  value       = "${cloudsigma_server.redis.network[0].ip_v4_conf[0].ip}:6379"
}

output "ip_address" {
  description = "IP address of the Redis server"
  value       = cloudsigma_server.redis.network[0].ip_v4_conf[0].ip
}

output "connection_string" {
  description = "Connection string for Redis (sensitive)"
  value       = "redis://:${var.redis_password}@${cloudsigma_server.redis.network[0].ip_v4_conf[0].ip}:6379/0"
  sensitive   = true
}

output "redis_version" {
  description = "Redis version installed"
  value       = var.redis_version
}
