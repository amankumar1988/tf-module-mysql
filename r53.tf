# This creates CNAME record for mongodb

resource "aws_route53_record" "mysql" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  name    = "mysql-${var.ENV}-${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"
  type    = "CNAME"
  ttl     = 10
  records = [aws_db_instance.mysql.address]
}