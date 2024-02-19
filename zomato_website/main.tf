# configure aws provider
provider "aws" {
  region = var.region
  profile = "tf-user1"
}

#create vpc
module "vpc" {
  source = "../modules/vpc"
  region = var.region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  pubsub1_cidr = var.pubsub1_cidr
  pubsub2_cidr = var.pubsub2_cidr
  prisub1_cidr = var.prisub1_cidr
  prisub2_cidr = var.prisub2_cidr
}

#create nat gateway
module "name" {
  source = "../modules/nat_gateway"
  vpc_id = module.vpc.vpc_id
  igw = module.vpc.igw
  pubsub1 = module.vpc.pubsub1
  pubsub2 = module.vpc.pubsub2
  prisub1 = module.vpc.prisub1
  prisub2 = module.vpc.prisub2
}

#create security groups
module "security_groups" {
  source = "../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}