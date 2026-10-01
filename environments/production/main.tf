module "networking" {
  source = "../../modules/networking"

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security" {
  source = "../../modules/security"

  environment = var.environment

  vpc_id   = module.networking.vpc_id
  vpc_cidr = var.vpc_cidr

  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
}
