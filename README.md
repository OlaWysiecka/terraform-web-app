# Terraform Web Application Infrastructure

Infrastructure as Code project for a multi-tier web application built with Terraform.

The project demonstrates how to structure Terraform code using reusable modules and separate environments.

## Project Status

The infrastructure has been implemented as a modular Terraform project.

Currently implemented:
- Networking module
- VPC
- Public and private subnets
- Internet Gateway
- NAT Gateways
- Route tables
- Security Groups
- Network ACLs
- Application Load Balancer
- EC2 instances
- Auto Scaling Group
- IAM role for EC2
- RDS PostgreSQL database
- Development environment
- Staging environment
- Production environment
- Remote state backend configuration

All environments successfully pass terraform validate.

## Architecture

The architecture follows a multi-tier design:

```text
                         Internet
                            |
                            v
                  +-------------------+
                  | Application Load  |
                  |      Balancer     |
                  +---------+---------+
                            |
                            v
                  +-------------------+
                  |   Web Servers     |
                  |       EC2         |
                  |   Private Subnet  |
                  +---------+---------+
                            |
                            v
                  +-------------------+
                  |    RDS Database   |
                  |   Private Subnet  |
                  +-------------------+

              VPC
        +-----------------------+
        |                       |
        | Public Subnets        |
        |                       |
        |   ALB / NAT Gateway   |
        |                       |
        +-----------------------+
        |                       |
        | Private Subnets       |
        |                       |
        |   EC2 / RDS           |
        |                       |
        +-----------------------+
```

## Project Structure
```bash
terraform-web-app/
│
├── environments/
│   ├── development/
│   ├── staging/
│   └── production/
│
├── modules/
│   ├── networking/
│   ├── security/
│   ├── compute/
│   └── database/
│
├── .gitignore
├── README.md
├── provider.tf
├── versions.tf
└── .terraform.lock.hcl

```
## Terraform Modules

### Networking

Responsible for:
* VPC
* Public subnets
* Private subnets
* Internet Gateway
* NAT Gateway
* Route tables
* Route table associations

### Security
Responsible for:
* Application Load Balancer Security Group
* Web server Security Group
* Database Security Group
* Public Network ACL
* Private Network ACL

The security model follows the principle of least privilege.

Traffic is intended to flow as follows:
```bash
Internet
   |
   | HTTP / HTTPS
   v
ALB
   |
   | HTTP
   v
EC2
   |
   | PostgreSQL : 5432
   v
RDS
```

### Environments
The project is designed to support three environments:

| Environment | Purpose |
|---|---|
| Development | Smaller resources and single-AZ architecture |
| Staging | Production-like environment with smaller resources |
| Production | Multi-AZ architecture with larger resources |


### Security
The infrastructure is designed with security in mind:
* Web servers are located in private subnets.
* Database is located in private subnets.
* RDS is not directly accessible from the Internet.
* Web servers accept HTTP traffic only from the Load Balancer.
* Database accepts PostgreSQL traffic only from the web server Security Group.
* IAM roles are used for EC2 instances.
* Terraform state is configured using environment-specific remote S3 backend definitions.


### Validation
Terraform configuration is validated using:
```bash
terraform fmt
terraform validate
terraform plan
```

## Technologies
* Terraform
* AWS provider
* Git
* GitHub
* Docker Desktop
* Visual Studio Code

## Project Goal
The goal of this project is to demonstrate a production-oriented Terraform architecture using:
* Infrastructure as Code
* Reusable Terraform modules
* Environment separation
* Network segmentation
* Least-privilege security
* High availability concepts
* Infrastructure version control

