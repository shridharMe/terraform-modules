variable "vpc_id" {
 description = "vpc id"
}

variable "public_subnets" {
 description = "public subnet"
 default     = []
}

variable "private_subnets" {
 description = "private subnet"
 default     = []
}
variable "cluster-name" {}
variable "workstation-external-cidr" {}