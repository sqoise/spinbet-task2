module "foundational" {
  source               = "./modules/foundational"
  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ec2" {
  source          = "./modules/services/ec2"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  instance_name   = var.instance_name
  subnet_id       = module.foundational.private_subnet_ids[0]
  vpc_id          = module.foundational.vpc_id
  security_groups = [module.foundational.security_group_ids["web_sg"]]
  iam_instance_profile = module.foundational.iam_instance_profile
}