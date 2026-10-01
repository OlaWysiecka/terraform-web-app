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

module "compute" {
  source = "../../modules/compute"

  environment = var.environment

  vpc_id = module.networking.vpc_id

  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id
  web_security_group_id = module.security.web_security_group_id

  instance_type    = var.instance_type
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
}

module "database" {
  source = "../../modules/database"

  environment = var.environment

  private_subnet_ids = module.networking.private_subnet_ids

  database_security_group_id = module.security.database_security_group_id

  instance_class    = var.db_instance_class
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  database_name     = var.db_name
  master_username   = var.db_username
  master_password   = var.db_password
  allocated_storage = var.db_allocated_storage
  multi_az          = var.db_multi_az
}
