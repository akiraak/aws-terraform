# ================================================
# Security group: management
# ================================================
resource "aws_security_group" "management" {
  name                   = "${local.service_prefix}-management"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.service_prefix}-management"
  }
}

# ssh
resource "aws_security_group_rule" "app_permit_ssh" {
  security_group_id = aws_security_group.management.id
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "22"
  to_port           = "22"
}

# ================================================
# Security group: app alb
# ================================================
resource "aws_security_group" "app_alb" {
  name                   = "${local.service_prefix}-app-alb"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.service_prefix}-app-alb"
  }
}

# http
resource "aws_security_group_rule" "alb_permit_from_internet_http" {
  security_group_id = aws_security_group.app_alb.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "permit from internet for http."
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
}

# https
resource "aws_security_group_rule" "alb_permit_from_internet_https" {
  security_group_id = aws_security_group.app_alb.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "permit from internet for https."
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
}

# ================================================
# Security group: app
# ================================================
resource "aws_security_group" "app" {
  name                   = "${local.service_prefix}-app"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.service_prefix}-app"
  }
}

# http
resource "aws_security_group_rule" "app_permit_from_app_alb_http" {
  security_group_id        = aws_security_group.app.id
  source_security_group_id = aws_security_group.app_alb.id
  description              = "permit from alb."
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "80"
  to_port                  = "80"
}

# ssh
resource "aws_security_group_rule" "app_permit_from_management_ssh" {
  security_group_id        = aws_security_group.app.id
  source_security_group_id = aws_security_group.management.id
  description              = "permit from management."
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "22"
  to_port                  = "22"
}

# ================================================
# Security group: app db
# ================================================
resource "aws_security_group" "app_db" {
  name                   = "${local.service_prefix}-app-db"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false
  tags = {
    Name = "${local.service_prefix}-app-db"
  }
}

resource "aws_security_group_rule" "app-db-sg-rule-mysql-from-app" {
  security_group_id = aws_security_group.app_db.id
  type = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "app-db-sg-rule-mysql-from-management" {
  security_group_id = aws_security_group.app_db.id
  type = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.management.id
}
