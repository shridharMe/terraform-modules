variable "alb_arn" {
  description = "The ALB ARN"
}

variable "ssl_policy" {
  description = "The SSL Policy"
  default     = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  description = "The Certificate ARN"
}

variable "default_target_group_arn" {
  description = "The default TargetGroup ARN"
}
