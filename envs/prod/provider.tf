terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {
  region              = local.region
  allowed_account_ids = local.aws_account_ids
  default_tags {
    tags = {
      Env    = local.env
      System = local.service_name
    }
  }
}
