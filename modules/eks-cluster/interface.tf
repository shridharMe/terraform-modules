variable "vpc_id" {
 description = "vpc id"
}

variable "public_subnet" {
 description = "public subnet"
 default     = []
}

variable "private_subnet" {
 description = "private subnet"
 default     = []
}

variable "cluster-name" {}
variable "node-security-id" {}
variable "workstation-external-cidr" {}