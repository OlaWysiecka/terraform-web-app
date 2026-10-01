environment = "production"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "eu-central-1a",
  "eu-central-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

instance_type    = "t3.small"
min_size         = 2
max_size         = 4
desired_capacity = 2
