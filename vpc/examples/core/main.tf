module "vpc" {
  source = "../.."

  namespace = "local"
  stage     = "test"
  name      = "min"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}