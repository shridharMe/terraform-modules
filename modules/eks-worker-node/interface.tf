variable "vpc_id" {
 description = "vpc id"
}

variable "private_subnet" {
 description = "private subnet"
 default     = []
}

variable "public_subnet" {
 description = "public subnet"
 default     = []
}
variable "node-instance-type" {}
variable "desired-capacity" {}
variable "max-size" {}
variable "min-size" {}
variable "cluster-name" {}
variable "cluster-endpoint" {}

