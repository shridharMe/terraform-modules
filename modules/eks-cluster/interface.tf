variable "vpc_id" {}
variable "public_subnets" {
    default     = []
}
variable "private_subnets_cidr" {
    default     = []
}

variable "cluster-name" {}
variable "workstation-external-cidr" {}