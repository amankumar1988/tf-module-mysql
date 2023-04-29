# Create RDS instance

resource "aws_db_instance" "mysql" {
  identifier              = "robot-${var.ENV}"
  allocated_storage       = var.MYSQL_RDS_STORAGE
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = var.MYSQL_RDS_VERSION
  instance_class          = var.MYSQL_RDS_INSTANCE_TYPE
  username                = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["RDS_USERNAME"]
  password                = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["RDS_PASSWORD"]
  parameter_group_name    = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot     = true   # this will ensure it won't take snapshot when you destroy
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allow_mysql.id]
}

# # Creates Parameter Group

resource "aws_db_parameter_group" "mysql_pg" {
  name   = "robot-${var.ENV}-mysql-pg"
  family = "mysql${var.MYSQL_RDS_VERSION}"

}

# Create subnet group

resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "robot-${var.ENV}-mysql-subet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "robot-${var.ENV}-mysql-subet-group"
  }
}