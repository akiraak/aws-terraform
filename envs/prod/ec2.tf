# ================================================
# EC2: AMI
# ================================================
data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

# ================================================
# EC2: management
# ================================================
resource "aws_instance" "management" {
  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  vpc_security_group_ids      = [aws_security_group.management.id]
  subnet_id                   = aws_subnet.public_management_1.id
  key_name                    = aws_key_pair.management.key_name
  instance_type               = local.instance_type_management
  associate_public_ip_address = "true"

  tags = {
    Name = "${local.service_prefix}-management"
  }

  user_data = <<EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum install -y mariadb-server git
  EOF
}

resource "aws_key_pair" "management" {
  key_name   = "${local.service_prefix}-key-management"
  public_key = file(local.public_key_path_management)
}

# ================================================
# EC2: app
# ================================================
resource "aws_iam_role" "app" {
    name = "${local.service_prefix}-app"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "app" {
    name = "${local.service_prefix}-app"
    role = aws_iam_role.app.id
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "app" {
    name = "${local.service_prefix}-app"
    role = aws_iam_role.app.name
}

resource "aws_key_pair" "app" {
  key_name   = "${local.service_prefix}-key-app"
  public_key = file(local.public_key_path_app)
}

resource "aws_instance" "app" {
  ami                     = data.aws_ssm_parameter.amzn2_ami.value
  vpc_security_group_ids  = [aws_security_group.app.id]
  subnet_id               = aws_subnet.private_app_1.id
  key_name                = aws_key_pair.app.key_name
  instance_type           = local.instance_type_app
  iam_instance_profile    = aws_iam_instance_profile.app.name
  tags = {
    Name = "${local.service_prefix}-app"
  }
}
