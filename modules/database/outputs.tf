output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.this.endpoint
}

output "rds_address" {
  description = "RDS database hostname"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "RDS database port"
  value       = aws_db_instance.this.port
}

output "rds_identifier" {
  description = "RDS database identifier"
  value       = aws_db_instance.this.identifier
}
