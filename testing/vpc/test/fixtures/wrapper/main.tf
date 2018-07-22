provider "aws" {
  region = "eu-west-1"
}


variable "vpc_name" {
  description = "vpc name"
}

variable "user_tag" {
  description = "user creating this resource"
}
  
variable "environment_tag" {
  description = "environment name"
}
       
         


module "vpc" {
 source             = "../../../../../modules/vpc"
 name               = "test-example"
 cidr               = ""
 public_subnets     = [""]
 private_subnets    = [""]
 azs                = ["eu-west-1a","eu-west-1b"]
 enable_nat_gateway = true 
 environment        = "dev"
 terraform          = "true"  
 owner              = "user"  
}

 output "region" {
  description = "Region we created the resources in."
  value       = "eu-west-1"
}