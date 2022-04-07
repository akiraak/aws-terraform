# ================================================
# RDS: app db
# ================================================
resource "aws_db_subnet_group" "app" {
  name        = "${local.service_prefix}-app"
  subnet_ids  = ["${aws_subnet.private_app_db_1.id}", "${aws_subnet.private_app_db_2.id}"]
  tags = {
      Name = "${local.service_prefix}-app"
  }
}

resource "aws_db_instance" "db" {
  identifier          = "${local.service_prefix}-app"
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "8.0.23"
  instance_class      = local.db_instance_type_app
  name                = "app"
  username            = "root"
  password            = "rootroot"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.app_db.id]
  db_subnet_group_name   = aws_db_subnet_group.app.name
}
