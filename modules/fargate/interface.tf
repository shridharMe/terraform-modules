// module ALB

//vpc
variable "name_prefix" {}

variable "cidr" {}

variable "public_subnets_cidr" {
  type = "list"
}

variable "private_subnets_cidr" {
  type = "list"
}

variable "azs" {}
variable "environment" {}
variable "owner" {}
variable "terraform" {}

//alb-sg
variable "source_cidr_block_inbound" {
  type = "list"
}

//target_group_task
variable "alb-health_check_path" {}

//listener
variable "certificate_arn" {}

variable "ssl_policy" {}

//listener-rule
variable "priority" {}

variable "path_pattern" {}

//log_group
variable "log_retention_in_days" {}

//fargate service
variable "desired_count" {}

variable "minimum_healthy_percent" {}
variable "maximum_healthy_percent" {}
variable "health_check_grace_period_seconds" {}
variable "task_container_assign_public_ip" {}
variable "task_container_port" {}

// fargate task
variable "task_definition_memory" {}

variable "task_definition_cpu" {}
variable "container_definitions" {}
