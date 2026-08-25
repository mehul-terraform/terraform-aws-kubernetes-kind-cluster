#--------------------------------------------------------------------------------------------------
# General / Provider Configuration
#--------------------------------------------------------------------------------------------------
aws_region  = "us-east-2"
projectname = "myexample"
environment = "dev"

#--------------------------------------------------------------------------------------------------
# 00 Tags
#--------------------------------------------------------------------------------------------------
tags = {
  projectname = "myexample"
  environment = "dev"
}

#--------------------------------------------------------------------------------------------------
# 02-VPC (for_each Subnets)
#--------------------------------------------------------------------------------------------------
vpc_name = "myexample-dev-vpc"
igw_name = "myexample-dev-igw"
vpc_cidr = "10.0.0.0/16"

public_subnets = {
  "pub-1a" = { cidr = "10.0.1.0/24", az = "us-east-2a" }
  "pub-1b" = { cidr = "10.0.2.0/24", az = "us-east-2b" }
  "pub-1c" = { cidr = "10.0.3.0/24", az = "us-east-2c" }
}

private_subnets = {
  "priv-1a" = { cidr = "10.0.251.0/24", az = "us-east-2a" }
  "priv-1b" = { cidr = "10.0.252.0/24", az = "us-east-2b" }
  "priv-1c" = { cidr = "10.0.253.0/24", az = "us-east-2c" }
}

#--------------------------------------------------------------------------------------------------
# 01-SecurityGroup (for_each)
#--------------------------------------------------------------------------------------------------
security_groups = {
  web = {
    vpc_id = "" # empty string will automatically use the VPC created by the VPC module
    ingress_rules = [
      { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
      { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Role = "web-sg" }
  } 
}

#--------------------------------------------------------------------------------------------------
# 03-KeyPair (for_each)
#--------------------------------------------------------------------------------------------------
key_pairs = {
  "myexample-dev-keypair" = {
    ssm_parameter_path = "/myexample/dev"
    tags               = {}
  }
}

#--------------------------------------------------------------------------------------------------
# 04-EC2 (for_each)
#--------------------------------------------------------------------------------------------------
instances = {
  web = {
    ami_id             = "ami-0e5497a77ef21b5ac"
    instance_type      = "t3.medium"
    subnet_id          = "" # dynamically resolved to public subnet
    security_group_ids = [] # dynamically resolved to web security group
    key_name           = "" # dynamically resolved to keypair module
    user_data          = "userdata.sh"
    tags               = { Role = "web", Tier = "public" }
  } 
}

#--------------------------------------------------------------------------------------------------
# 07-S3 (for_each)
#--------------------------------------------------------------------------------------------------
s3_buckets = {
  dev-bucket = {
    bucket_name           = "myexample-dev-bucket"
    enable_versioning     = true
    enable_static_website = true
    index_document        = "index.html"
    error_document        = "error.html"
    force_destroy         = true
    tags                  = { Environment = "dev" }
  }  
}
