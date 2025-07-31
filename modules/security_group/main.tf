# Web Security Group Resource
resource "aws_security_group" "web_sg" {
  name        = "${var.project}-web-sg"
  description = "Allow web, HTTPS, and SSH from Bastion"
  vpc_id      = var.vpc_id

  # Ingress Rule: HTTP
  ingress {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress Rule: HTTPS
  ingress {
    description = "Allow HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rule: All
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-web-sg"
  }
}

# MySQL Security Group Resource
resource "aws_security_group" "mysql_sg" {
  name        = "${var.project}-mysql-sg"
  description = "Allow MySQL access from Web EC2"
  vpc_id      = var.vpc_id

  # Ingress Rule: MySQL from Web SG
  ingress {
    description     = "Allow MySQL from Web EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  # Egress Rule: All
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-mysql-sg"
  }
}

# Bastion Security Group Resource
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-bastion-sg"
  description = "SSH access for Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-bastion-sg"
  }
}

# Security Group Rule: Allow SSH from Bastion SG to Web SG
resource "aws_security_group_rule" "web_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
  description              = "Allow SSH from Bastion Host"
}
