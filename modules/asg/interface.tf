#
# Launch Configuration Variables
#
variable "launch_conf_name" {
  description = "launch configuration name"
}

variable "required" {
  description = "if you required this resource than set it to 1 or 0"
}

variable "ami_id" {
  description = "The AMI to use with the launch configuration"
}

variable "instance_type" {}

variable "iam_instance_role" {
  description = "The IAM role the launched instance will use"
}

variable "key_name" {
  description = "The SSH public key name (in EC2 key-pairs) to be injected into instances"
}

variable "security_group" {
  description = "ID of SG the launched instance will use"
}

variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

variable "asg_name" {}

variable "asg_desired_capacity" {
  description = "The number of instances"
}

variable "asg_maximum_number_of_instances" {
  description = "The number of instances we want in the ASG"
}

variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 300
}

variable "health_check_type" {
  description = "The health check used by the ASG to determine health"
  default     = "ELB"
}

variable "load_balancer_names" {
  default     = []
  description = "A comma seperated list string of ELB names the ASG should associate instances with"
}

variable "availability_zones" {
  default     = []
  description = ""
}

variable "vpc_zone_subnets" {
  default     = []
  description = "A comma seperated list string of VPC subnets to associate with ASG, should correspond with var.availability_zones zones"
}

variable "tags" {
  type        = "map"
  description = "Tag for the product category of this resource"
}
