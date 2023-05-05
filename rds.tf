# Creates RDS Instance 
resource "aws_db_instance" "mysql" {
  identifier              = "robot-${var.ENV}-mysql"
  allocated_storage       = var.MYSQL_RDS_STORAGE
  # db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = var.MYSQL_RDS_ENGINE_VERSION
  instance_class          = var.MYSQL_RDS_INSTANCE_TYPE
  username                = local.RDS_USER
  password                = local.RDS_PASS
  parameter_group_name    = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot     = true                          # This will ensure it won't take snapshot when you destroy
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allow_mysql.id]
}


resource "aws_db_parameter_group" "mysql_pg" {
  name   = "robot-${var.ENV}-mysql-pg"
  family = "mysql${var.MYSQL_RDS_ENGINE_VERSION}"
}

resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "robot-${var.ENV}-mysql-subet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "robot-${var.ENV}-mysql-subet-group"
  }
}