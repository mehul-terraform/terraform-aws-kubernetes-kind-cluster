#--------------------------------------------------------------------------------------------------
# 02-VPC
#--------------------------------------------------------------------------------------------------
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Map of logical name -> public subnet ID"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Map of logical name -> private subnet ID"
}

#--------------------------------------------------------------------------------------------------
# 01-SecurityGroup
#--------------------------------------------------------------------------------------------------
output "security_group_ids" {
  value       = module.security_group.security_group_ids
  description = "Map of logical name -> security group ID"
}

#--------------------------------------------------------------------------------------------------
# 03-KeyPair
#--------------------------------------------------------------------------------------------------
output "key_names" {
  value       = module.keypair.key_names
  description = "Map of logical name -> key pair name"
}

output "keypair_ssm_parameter_names" {
  value       = module.keypair.ssm_parameter_names
  description = "Map of key pair name -> SSM parameter path where the private key is stored"
}

#--------------------------------------------------------------------------------------------------
# 04-EC2
#--------------------------------------------------------------------------------------------------
output "ec2_instance_ids" {
  value       = module.ec2.instance_ids
  description = "Map of logical name -> EC2 instance ID"
}

output "ec2_public_ips" {
  value       = module.ec2.public_ips
  description = "Map of logical name -> public IP address"
}

output "ec2_private_ips" {
  value       = module.ec2.private_ips
  description = "Map of logical name -> private IP address"
}

#--------------------------------------------------------------------------------------------------

