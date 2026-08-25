output "key_names" {
  description = "Map of logical key name -> AWS Key Pair name"
  value       = { for k, v in aws_key_pair.this : k => v.key_name }
}

output "ssm_parameter_names" {
  description = "Map of logical key name -> SSM parameter path where the private key is stored"
  value       = { for k, v in aws_ssm_parameter.private_key : k => v.name }
}

output "ssm_parameter_arns" {
  description = "Map of logical key name -> SSM parameter ARN"
  value       = { for k, v in aws_ssm_parameter.private_key : k => v.arn }
}
