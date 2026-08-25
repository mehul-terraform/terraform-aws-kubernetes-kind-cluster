variable "projectname" { type = string }
variable "environment" { type = string }

# Map of key pairs to create.
# Key = AWS Key Pair name (e.g. "myapp-dev-keypair")
#
# Example:
#   key_pairs = {
#     "myapp-dev-keypair" = {
#       ssm_parameter_path = "/myapp/dev"
#       tags               = {}
#     }
#   }
#
# The private key will be stored in SSM at: <ssm_parameter_path>/<key_name>
# e.g. /myapp/dev/myapp-dev-keypair
variable "key_pairs" {
  description = "Map of key pairs to create. Key = AWS key pair name."
  type = map(object({
    ssm_parameter_path = string      # SSM path prefix, e.g. "/myapp/dev"
    tags               = map(string) # Additional tags to apply
  }))
  default = {}
}
