resource "null_resource" "schema" {

  depends_on = [ aws.aws_db_instance.mysql ]

  provisioner "local-exec" {
        command = <<EOF
        cd /tmp 
        curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
        unzip -o mysql.zip 
        cd mysql-main 
        mysql -h ${aws_db_instance.mysql.address} -uadmin1 -proboshop1 < shipping.sql
        EOF
    }
}