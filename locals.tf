# Whenever you have some common fields or anything which is highly used, you can consider that in locals and can call it on your need

locals {
    RDS_USER = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["RDS_USERNAME"]
    RDS_PASS = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["RDS_PASSWORD"]
}