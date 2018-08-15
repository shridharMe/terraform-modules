variable "listener_arn" {
  description = "The Listener ARN"
}

variable "target_group_arn" {
  description = "The TargetGroup ARN"
}

variable "priority" {
  description = "The priority of Rule"
}

variable "path_pattern" {
  description = "The path pattern used by the rule"
}
