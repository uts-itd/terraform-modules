module "vpc" {
  source = "../.."

  namespace        = "local"
  stage            = "test"
  name             = "min"
  is_highavailable = false
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}