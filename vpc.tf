module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  azs             = [var.zone1, var.zone2]
  name            = var.vpc_name
  cidr            = var.vpc_cidr
  private_subnets = [var.priv_sub_cidr_1, var.priv_sub_cidr_2]
  public_subnets  = [var.pub_sub_cidr_1, var.pub_sub_cidr_2]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {

    terraform   = "true"
    environment = "true"


  }
  vpc_tags = {
    Name = var.vpc_name
  }
}