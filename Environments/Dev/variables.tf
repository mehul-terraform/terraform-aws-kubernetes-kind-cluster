#--------------------------------------------------------------------------------------------------
# General / Provider Configuration
#--------------------------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "projectname" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

#--------------------------------------------------------------------------------------------------
# 02-VPC
#--------------------------------------------------------------------------------------------------

variable "vpc_name" {
  type        = string
  description = "Custom name for the VPC"
}

variable "igw_name" {
  type        = string
  description = "Custom name for the Internet Gateway"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  description = "Map of public subnets. Key = logical name."
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

variable "private_subnets" {
  description = "Map of private subnets. Key = logical name."
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

#--------------------------------------------------------------------------------------------------
# 01-SecurityGroup
#--------------------------------------------------------------------------------------------------

variable "security_groups" {
  description = "Map of security groups to create. Key = logical name."
  type = map(object({
    vpc_id = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    tags = map(string)
  }))
  default = {}
}

#--------------------------------------------------------------------------------------------------
# 03-KeyPair
#--------------------------------------------------------------------------------------------------

variable "key_pairs" {
  description = "Map of key pairs to create. Key = key pair name."
  type = map(object({
    ssm_parameter_path = string      # SSM path prefix, e.g. "/myapp/dev"
    tags               = map(string) # Additional tags
  }))
  default = {}
}

#--------------------------------------------------------------------------------------------------
# 04-EC2
#--------------------------------------------------------------------------------------------------

variable "instances" {
  description = "Map of EC2 instances to create. Key = logical name."
  type = map(object({
    ami_id             = string
    instance_type      = string
    subnet_id          = string
    security_group_ids = list(string)
    key_name           = string
    user_data          = string
    tags               = map(string)
  }))
  default = {}
}

#--------------------------------------------------------------------------------------------------
# 07-S3
#--------------------------------------------------------------------------------------------------

variable "s3_buckets" {
  description = "Map of S3 buckets to create. Key = logical name."
  type = map(object({
    bucket_name           = string
    enable_versioning     = bool
    enable_static_website = bool
    index_document        = string
    error_document        = string
    force_destroy         = bool
    tags                  = map(string)
  }))
  default = {}
}
