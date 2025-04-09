output "vpc_id" {
  description = "ID of the created VPC (VLAN)"
  value       = cloudsigma_vlan.this.id
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = cloudsigma_vlan.this.name
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = cloudsigma_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = cloudsigma_subnet.private[*].id
}

output "firewall_id" {
  description = "ID of the created firewall"
  value       = cloudsigma_firewall.this.id
}

output "cidr_block" {
  description = "CIDR block of the VPC"
  value       = var.cidr_block
}
