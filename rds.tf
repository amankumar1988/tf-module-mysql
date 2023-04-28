# Create RDS instance

resource "aws_db_instance" "mysql" {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = "admin1"
  password                = "roboshop1"
  parameter_group_name    = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot     = true   # this will ensure it won't take snapshot when you destroy
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_groups_id  = [aws_security_group.allow_mysql.id]
}

# # Creates Parameter Group

resource "aws_db_parameter_group" "mysql_pg" {
  name   = "robot-${var.ENV}-mysql-pg"
  family = "mysql5.7"

}

# Create subnet group

resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "robot-${var.ENV}-mysql-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "My DB subnet group"
  }
}