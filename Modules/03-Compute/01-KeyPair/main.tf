terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

# Generate one RSA private key per key pair entry
resource "tls_private_key" "this" {
  for_each  = var.key_pairs
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Upload each public key to AWS as a Key Pair
resource "aws_key_pair" "this" {
  for_each   = var.key_pairs
  key_name   = each.key
  public_key = tls_private_key.this[each.key].public_key_openssh
}

# Store each private key securely in SSM Parameter Store as SecureString
resource "aws_ssm_parameter" "private_key" {
  for_each    = var.key_pairs
  name        = "${each.value.ssm_parameter_path}/${each.key}"
  description = "EC2 private key for key pair: ${each.key}"
  type        = "SecureString"
  value       = tls_private_key.this[each.key].private_key_pem

  tags = merge(each.value.tags, {
    Name        = "${each.value.ssm_parameter_path}/${each.key}"
    Environment = var.environment
    Projectname = var.projectname
  })
}
