environment = "staging"

vpc_cidr = "10.20.0.0/16"

availability_zones = [
  "eu-central-1a",
  "eu-central-1b"
]

public_subnet_cidrs = [
  "10.20.1.0/24",
  "10.20.2.0/24"
]

private_subnet_cidrs = [
  "10.20.11.0/24",
  "10.20.12.0/24"
]

instance_type    = "t3.small"
min_size         = 1
max_size         = 2
desired_capacity = 1

db_instance_class    = "db.t3.small"
db_engine            = "postgres"
db_engine_version    = "16"
db_name              = "appdb"
db_username          = "appuser"
db_allocated_storage = 20
db_multi_az          = true
