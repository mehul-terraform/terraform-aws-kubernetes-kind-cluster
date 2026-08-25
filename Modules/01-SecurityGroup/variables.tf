variable "projectname" {
  type        = string
  description = "Project name for tagging"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging"
}

# Map of security groups to create.
# Key = logical name (e.g. "web", "app", "db")
#
# Example:
#   security_groups = {
#     web = {
#       vpc_id = "vpc-xxxx"
#       ingress_rules = [
#         { from_port = 80,  to_port = 80,  protocol = "tcp",  cidr_blocks = ["0.0.0.0/0"] },
#         { from_port = 443, to_port = 443, protocol = "tcp",  cidr_blocks = ["0.0.0.0/0"] },
#         { from_port = 22,  to_port = 22,  protocol = "tcp",  cidr_blocks = ["10.0.0.0/8"] },
#       ]
#       egress_rules = [
#         { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
#       ]
#       tags = {}
#     }
#   }
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

variable "vpc_id_default" {
  type        = string
  description = "Default VPC ID to use if not specified in the security group map"
  default     = ""
}