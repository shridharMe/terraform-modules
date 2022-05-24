variable "vpc_id" {
  default     = ""
  description = "VPC id"
}

variable "vpc_cidr_block" {
  type        = string
  default     = ""
  description = "VPC cidrs"
}

variable "sg_for_lambda_name" {
  default     = "allow_tls"
  description = "SG name"
}