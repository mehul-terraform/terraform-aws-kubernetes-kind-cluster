variable "projectname" {
  type        = string
  description = "Project name for tagging"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging"
}

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

# Map of public subnets. Key = logical name (e.g. "pub-1a", "pub-1b")
#
# Example:
#   public_subnets = {
#     "pub-1a" = { cidr = "10.0.1.0/24", az = "us-east-2a" }
#     "pub-1b" = { cidr = "10.0.2.0/24", az = "us-east-2b" }
#     "pub-1c" = { cidr = "10.0.3.0/24", az = "us-east-2c" }
#   }
variable "public_subnets" {
  description = "Map of public subnets. Key = logical name."
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

# Map of private subnets. Key = logical name (e.g. "priv-1a", "priv-1b")
variable "private_subnets" {
  description = "Map of private subnets. Key = logical name."
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}
