variable "vpc_id" {}
variable "private_subnet" {
    default     = []
}
variable "public_subnet_cidr" {
    default     = []
}
variable "node-instance-type" {}
variable "desired-capacity" {}
variable "max-size" {}
variable "min-size" {}
variable "cluster-name" {}
variable "cluster-endpoint" {}

