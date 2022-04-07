variable "vpc" {
  default = {
    "vpc_cidr_block" = "10.0.0.0/16"
    "subnet_public_management_1_cidr_block" = "10.0.240.0/24"
    "subnet_public_management_2_cidr_block" = "10.0.241.0/24"
    "subnet_public_app_alb_1_cidr_block" = "10.0.0.0/24"
    "subnet_public_app_alb_2_cidr_block" = "10.0.1.0/24"
    "subnet_private_app_1_cidr_block" = "10.0.8.0/24"
    "subnet_private_app_2_cidr_block" = "10.0.9.0/24"
    "subnet_private_app_db_1_cidr_block" = "10.0.16.0/24"
    "subnet_private_app_db_2_cidr_block" = "10.0.17.0/24"
  }
}
