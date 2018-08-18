variable "name_prefix" {
  type = "string"
}

 

variable "internal" {
  description = "Sets if the ALB is internal facing"
  default     = false
}

variable "security_groups" {
  type = "list"
}

variable "subnets" {
  type = "list"
}

variable "tags" {
  type = "map"

  default = {
    created_by = "terraform"
  }
}


variable "route53zoneid" {}

variable "route53type" {
  default = "CNAME"
}

variable "route53ttl" {
  default = 60
}
