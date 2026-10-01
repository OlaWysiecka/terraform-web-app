output "vpc_id" {
  description = "Development VPC ID"
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "Development ALB DNS name"
  value       = module.compute.alb_dns_name
}

output "rds_endpoint" {
  description = "Development RDS endpoint"
  value       = module.database.rds_endpoint
}
