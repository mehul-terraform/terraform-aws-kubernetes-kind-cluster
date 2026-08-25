#--------------------------------------------------------------------------------------------------
# 01-SecurityGroup
#--------------------------------------------------------------------------------------------------

module "security_group" {
  source          = "../../Modules/01-SecurityGroup"
  projectname     = var.projectname
  environment     = var.environment
  security_groups = var.security_groups
  vpc_id_default  = module.vpc.vpc_id
}

#--------------------------------------------------------------------------------------------------
# 02-VPC
#--------------------------------------------------------------------------------------------------

module "vpc" {
  source          = "../../Modules/02-Networking/02-VPC"
  projectname     = var.projectname
  environment     = var.environment
  vpc_name        = var.vpc_name
  igw_name        = var.igw_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

#--------------------------------------------------------------------------------------------------
# 03-KeyPair
#--------------------------------------------------------------------------------------------------

module "keypair" {
  source      = "../../Modules/03-Compute/01-KeyPair"
  projectname = var.projectname
  environment = var.environment
  key_pairs   = var.key_pairs
}

#--------------------------------------------------------------------------------------------------
# 04-EC2
#--------------------------------------------------------------------------------------------------

module "ec2" {
  source                     = "../../Modules/03-Compute/02-EC2"
  projectname                = var.projectname
  environment                = var.environment
  instances                  = var.instances
  public_subnet_ids          = values(module.vpc.public_subnet_ids)
  private_subnet_ids         = values(module.vpc.private_subnet_ids)
  default_security_group_ids = [module.security_group.security_group_ids["web"]]
  default_key_name           = values(module.keypair.key_names)[0]
}

#--------------------------------------------------------------------------------------------------
