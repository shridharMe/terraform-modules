variable "name" {
  description = "The target group name"
}

variable "port" {
  description = "The target group port"
  default     = "80"
}

variable "target_type" {
  default ="instance"
}


variable "protocol" {
  description = "The target group protocol"
  default     = "HTTP"
}

variable "vpc_id" {
  description = "The VPC ID where the target group will be attached"
}

variable "deregistration_delay" {
  description = "(Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  default     = 30
}

variable "stickiness_type" {
  description = "The type of sticky sessions. The only current possible value is lb_cookie"
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds)."
  default     = 86400                                                                                                                                                                                                                                                                                         # 1 day in seconds
}

variable "stickiness_enabled" {
  description = "Boolean to enable / disable stickiness"
  default     = false
}

variable "health_check_path" {
  description = "(Optional) The destination for the health check request. Default /."
  default     = "/"
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. Defaults to 200. You can specify multiple values (for example, '200,202') or a range of values (for example, '200-299')."
  default     = "200-299"
}

variable "tags" {
  type = "map"

  default = {
    created_by = "terraform"
  }
}
