output "vpc_id" {
  description = "Staging VPC ID"
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "Staging ALB DNS name"
  value       = module.compute.alb_dns_name
}

output "rds_endpoint" {
  description = "Staging RDS endpoint"
  value       = module.database.rds_endpoint
}
