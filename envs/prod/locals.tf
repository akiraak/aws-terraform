locals {
  service_name = "localfood"
  env = "prod"
  service_prefix = "${local.service_name}-${local.env}"
  aws_account_ids = ["699938552441"]
  region = "us-west-1"
  az_1 = "us-west-1a"
  az_2 = "us-west-1c"

  /*
  "route53_zone_app_name" = "hokugin-cabo-pro.lab-dis.com"
  "acm_certificate_arn" = "arn:aws:acm:ap-northeast-1:955214695009:certificate/729a103e-51b6-48fb-adab-57a1cfe74eda"
  "instance_type_management" = "t3.nano"
  "instance_type_app" = "t3.micro"
  "public_key_path_management" = "../../key-cabo-management.pub"
  "public_key_path_app" = "../../key-cabo-app.pub"
  "db_instance_type_app" = "db.t3.micro"
  */
}