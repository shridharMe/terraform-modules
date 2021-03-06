variable "vpc_id" {}
variable "private_subnet" {}

variable "public_subnet_cidr" {
  type = "list"
}

variable "node-instance-type" {}
variable "desired-capacity" {}
variable "max-size" {}
variable "min-size" {}
variable "cluster-name" {}
variable "cluster-endpoint" {}
variable "cluster-certificate-data" {}
