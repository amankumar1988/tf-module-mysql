# Create security group

resource "aws_security_group" "allow_mysql" {
  name        = "robot-${var.ENV}-mysql-sg"
  description = "Allow mysql inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Allows docdb from local NW"
    from_port        = var.MYSQL_RDS_PORT
    to_port          = var.MYSQL_RDS_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  ingress {
    description      = "Allows docdb from defaul NW"
    from_port        = var.MYSQL_RDS_PORT
    to_port          = var.MYSQL_RDS_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "robot-${var.ENV}-mysql-sg"
  }
}