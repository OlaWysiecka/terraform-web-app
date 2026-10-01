resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-alb-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web servers"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-web-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "database" {
  name        = "${var.environment}-db-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from web servers"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-db-sg"
    Environment = var.environment
  }
}

resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-public-nacl"
    Environment = var.environment
  }
}

resource "aws_network_acl_rule" "public_ingress_http" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 100
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

  from_port = 80
  to_port   = 80
}

resource "aws_network_acl_rule" "public_ingress_https" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 110
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

  from_port = 443
  to_port   = 443
}

resource "aws_network_acl_rule" "public_ingress_ephemeral" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 120
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

  from_port = 1024
  to_port   = 65535
}

resource "aws_network_acl_rule" "public_egress_all" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 100
  egress      = true
  protocol    = "-1"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"
}

resource "aws_network_acl" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-private-nacl"
    Environment = var.environment
  }
}

resource "aws_network_acl_rule" "private_ingress_vpc" {
  network_acl_id = aws_network_acl.private.id

  rule_number = 100
  egress      = false
  protocol    = "-1"
  rule_action = "allow"

  cidr_block = var.vpc_cidr
}

resource "aws_network_acl_rule" "private_egress_all" {
  network_acl_id = aws_network_acl.private.id

  rule_number = 100
  egress      = true
  protocol    = "-1"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"
}

resource "aws_network_acl_association" "public" {
  count = length(var.public_subnet_ids)

  network_acl_id = aws_network_acl.public.id
  subnet_id     = var.public_subnet_ids[count.index]
}

resource "aws_network_acl_association" "private" {
  count = length(var.private_subnet_ids)

  network_acl_id = aws_network_acl.private.id
  subnet_id     = var.private_subnet_ids[count.index]
}
