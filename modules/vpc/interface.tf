
variable "name" {
  description = "The name of the VPC"
}

variable "environment" {
  description = "The name of the VPC"
}


variable "terraform" {
  description = "The name of the VPC"
}

variable "owner" {
  description = "The name of the VPC"
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

variable "enable_nat_gateway" {
  description = "Do you you want NAT Gateway for each private subnet"
  default     = "false"
}
variable "public_eip_id" {
 description = "A list of public IP ID"
 default     = []
}


