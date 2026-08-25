output "instance_ids" {
  description = "Map of logical name -> EC2 instance ID"
  value       = { for k, v in aws_instance.this : k => v.id }
}

output "public_ips" {
  description = "Map of logical name -> public IP"
  value       = { for k, v in aws_instance.this : k => v.public_ip }
}

output "private_ips" {
  description = "Map of logical name -> private IP"
  value       = { for k, v in aws_instance.this : k => v.private_ip }
}

output "instance_arns" {
  description = "Map of logical name -> EC2 ARN"
  value       = { for k, v in aws_instance.this : k => v.arn }
}
