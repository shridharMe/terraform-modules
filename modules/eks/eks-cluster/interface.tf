variable "vpc_id" {}
variable "public_subnets" {}

variable "private_subnets_cidr" {
  type = "list"
}

variable "cluster-name" {}
variable "workstation-external-cidr" {}
