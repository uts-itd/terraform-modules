# Cloudposse labels
variable "namespace" {}
variable "stage" {}
variable "name" {}
variable "delimiter" {
  default = "-"
}

# VPC Variables
variable "subnet_bits" {
  type        = number
  description = "Subnet bits"
  default     = 8
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
  type        = string
  validation {
    condition = (
      try(cidrhost(var.cidr_block, 0), null) == "10.0.0.0" ||
      try(cidrhost(var.cidr_block, 0), null) == "172.16.0.0" ||
      try(cidrhost(var.cidr_block, 0), null) == "192.168.0.0"
    )
    error_message = "Invalid VPC CIDR block."
  }
}

variable "enable_dns_hostnames" {
  default     = true
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "enable_dns_support" {
  default     = true
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC"
}

variable "is_highavailable" {
  default = true
}