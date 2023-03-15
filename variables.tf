variable "aws_region" {
  description = "AWS region to launch servers."
  type        = string
  default     = "us-west-2"

  validation {
    condition     = can(regex("^eu-.*|^us-.*|^ap-.*", var.aws_region))
    error_message = "Error: Incorrect AWS Region."
  }
}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "wa_osapo"

  validation {
    condition     = var.aws_profile != null && var.aws_profile != ""
    error_message = "Error: AWS Profile is absent."
  }
}

variable "aws_key_name" {
  description = "SSH Key name"
  type        = string
  default     = "WA"
}

variable "type" {
  description = "Role of the setup: non-prod or prod"
  type        = string
  default     = "non-prod"

  validation {
    condition     = contains(["non-prod", "prod", "uat", "demo"], var.type)
    error_message = "Error: Incorrect project type. Allowed values: non-prod, prod, uat, demo."
  }
}
