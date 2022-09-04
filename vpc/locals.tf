module "vpc_labels" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = ["network"]
}

locals {
  vpc_name               = "${module.vpc_labels.id}-vpc"
  public_subnet_name     = "${module.vpc_labels.id}-pub"
  private_subnet_name    = "${module.vpc_labels.id}-pri"
  database_subnet_name   = "${module.vpc_labels.id}-dbs"
  internetgateway_name   = "${module.vpc_labels.id}-igw"
  public_routetable_name = "${module.vpc_labels.id}-rtb-pub"
  nat_gateway_name       = "${module.vpc_labels.id}-ngw"
  elastic_ip_name        = "${module.vpc_labels.id}-eip"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}