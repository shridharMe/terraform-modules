variable "vpc_id" {
  default     = ""
  description = "VPC id (optional)"
}

variable "private_subnets_ids" {
  type        = list(any)
  default     = []
  description = "Private Subnet Id's"
}


variable "vpc_cidr_block" {
  type        = string
  default     = ""
  description = "VPC cidrs"
}

variable "lambda_source_dir" {
  type        = string
  default     = ""
  description = "Lambda source code directory path"
}


variable "lambda_role_arn" {
  type        = string
  default     = ""
  description = "Lambda role arn"
}

variable "security_group_ids" {
  type        = list(any)
  default     = []
  description = "Securtiy Group Ids"

}

variable "lambda_function_name" {
  type        = string
  default     = "lambda_bgd"
  description = "Lambda function name"
}

variable "lambda_filename" {
  type        = string
  description = "lambda code file path"
}

variable "lambda_source_code_hash" {
  type        = string
  description = "lambda code hash"
}


variable "lambda_handler" {
  type        = string
  default     = "index.handler"
  description = "lambda function handler"

}

variable "lambda_runtime" {
  type        = string
  default     = "python3.7"
  description = "lambda function runtime"

}