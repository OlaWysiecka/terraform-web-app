output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "web_security_group_id" {
  description = "Security group ID for web servers"
  value       = aws_security_group.web.id
}

output "database_security_group_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.database.id
}
