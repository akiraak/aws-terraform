terraform {
  backend "s3" {
    bucket = "mspv2-localfood-tfstate"
    key    = "v1.0.0.tfstate"
    region = "us-west-1"
  }
}
