output "security_group_ids" {
  description = "Map of logical name -> security group ID"
  value       = { for k, v in aws_security_group.this : k => v.id }
}

output "security_group_arns" {
  description = "Map of logical name -> security group ARN"
  value       = { for k, v in aws_security_group.this : k => v.arn }
}
