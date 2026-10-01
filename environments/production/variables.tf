variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_engine" {
  description = "RDS engine"
  type        = string
}

variable "db_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Database storage in GB"
  type        = number
}

variable "db_multi_az" {
  description = "Enable RDS Multi-AZ"
  type        = bool
}
