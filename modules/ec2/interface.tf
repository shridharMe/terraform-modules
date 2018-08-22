variable "key_name" {
  description = "Server key"
}

variable "name" {
  description = "name of instance"
}

variable "type" {
  description = "The instance type for the ami to run ami"
  default     = "t2.micro"
}

variable "user_data" {
  description = "The instance type for the ami to run ami"
  default     = ""
}

variable "environment" {
  description = "environment tag name"
}

variable "resource_type_tag" {
  description = "Tag for the type of resource"
}

variable "subnet_ids" {
  default     = []
  description = "subnets available on the VPC"
}

variable "ami_id" {
  description = "The AMI to use"
  default     = "ami-70edb016"
}

variable "number_of_instances" {
  description = "number of instances to make"
  default     = 1
}

variable "tags" {
  default = {
    created_by = "terraform"
  }
}

variable "vpc_id" {
  description = "vpc for the security group"
}

variable "security_groups" {
  description = "the sgs to attach to the ec2 instance"
  default     = []
}

variable "route53_zone_id" {
  description = "zone id for the image"
  default     = "Z39YUFVEP74CTL"
}

variable "volume_size" {
  description = "size of the root volume"
  default     = 30
}

variable "volume_type" {
  description = "type of the root volume"
  default     = "gp2"
}

variable "delete_on_termination" {
  default = "true"
}

variable "iam_instance_profile" {
  default = ""
}

variable "service_tag" {
  default = ""
}

variable "servicecomponent_tag" {
  default = ""
}

variable "networktier_tag" {
  default = ""
}
