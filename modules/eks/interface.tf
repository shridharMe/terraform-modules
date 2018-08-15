variable "name" {
  description = "The name of the VPC"
}

variable "environment" {
  description = "The name of the environment"
}

variable "terraform" {
  description = "created by using terraform"
}

variable "owner" {
  description = "The name of the VPC owner"
}

variable "cidr" {
  description = "The cidr block of the VPC"
}

variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "public_subnets" {
  description = "A list of public subnets to be created"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "azs" {
  description = "The availablity zones to use"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "cluster-name" {
  description = "cluster name"
}

variable "node-instance-type" {
  default = ""
}

variable "desired-capacity" {
  default = ""
}

variable "max-size" {
  default = ""
}

variable "min-size" {
  default = ""
}

variable "cluster-name" {
  default = "dev-eks"
}
