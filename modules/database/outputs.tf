output "id" {
  description = "ID of the database server"
  value       = cloudsigma_server.database.id
}

output "name" {
  description = "Name of the database server"
  value       = cloudsigma_server.database.name
}

output "endpoint" {
  description = "Connection endpoint for the database"
  value       = "${cloudsigma_server.database.network[0].ip_v4_conf[0].ip}:${var.engine == "postgresql" ? "5432" : (var.engine == "mysql" ? "3306" : "27017")}"
}

output "ip_address" {
  description = "IP address of the database server"
  value       = cloudsigma_server.database.network[0].ip_v4_conf[0].ip
}

output "connection_string" {
  description = "Connection string for the database (sensitive)"
  value       = var.engine == "postgresql" ? "postgresql://${var.db_user}:${var.db_password}@${cloudsigma_server.database.network[0].ip_v4_conf[0].ip}:5432/${var.db_name}" : (var.engine == "mysql" ? "mysql://${var.db_user}:${var.db_password}@${cloudsigma_server.database.network[0].ip_v4_conf[0].ip}:3306/${var.db_name}" : "mongodb://${var.db_user}:${var.db_password}@${cloudsigma_server.database.network[0].ip_v4_conf[0].ip}:27017/${var.db_name}")
  sensitive   = true
}

output "engine" {
  description = "Database engine type"
  value       = var.engine
}

output "engine_version" {
  description = "Database engine version"
  value       = var.engine_version
}
