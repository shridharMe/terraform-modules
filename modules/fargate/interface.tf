variable "name_prefix" {}
variable "vpc_id" {}
variable "log_retention_in_days" {}
variable "tags" {}
variable "minimum_healthy_percent" {}
variable "maximum_healthy_percent" {}
variable "health_check_grace_period_seconds" {}
variable "private_subnet_ids" {}
variable "task_container_assign_public_ip" {}
variable "task_container_port" {}
variable "task_definition_memory" {}
variable "container_definitions" {}

//alb
variable "priority" {}

variable "path_pattern" {}
variable "certificate_arn" {}
variable "ssl_policy" {}
variable "health_check_path" {}
variable "source_cidr_block_inbound" {}
