environment = "development"

vpc_cidr = "10.10.0.0/16"

availability_zones = [
  "eu-central-1a"
]

public_subnet_cidrs = [
  "10.10.1.0/24"
]

private_subnet_cidrs = [
  "10.10.11.0/24"
]

instance_type    = "t3.micro"
min_size         = 1
max_size         = 2
desired_capacity = 1

db_instance_class    = "db.t3.micro"
db_engine            = "postgres"
db_engine_version    = "16"
db_name              = "appdb"
db_username          = "appuser"
db_allocated_storage = 20
db_multi_az          = false
