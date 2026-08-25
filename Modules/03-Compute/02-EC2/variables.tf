variable "projectname" {
  type        = string
  description = "Project name for tagging"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging"
}

# Map of EC2 instances to create.
# Key = logical name (e.g. "web", "app", "db")
#
# Example:
#   instances = {
#     web = {
#       ami_id             = "ami-0e5497a77ef21b5ac"
#       instance_type      = "t3.micro"
#       subnet_id          = "subnet-xxxx"
#       security_group_ids = ["sg-xxxx"]
#       key_name           = "my-keypair"
#       user_data          = ""
#       tags               = { Role = "web" }
#     }
#   }
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

variable "public_subnet_ids" {
  type    = list(string)
  default = []
}

variable "private_subnet_ids" {
  type    = list(string)
  default = []
}

variable "default_security_group_ids" {
  type    = list(string)
  default = []
}

variable "default_key_name" {
  type    = string
  default = ""
}
