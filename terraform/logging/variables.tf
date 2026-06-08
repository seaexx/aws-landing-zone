variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "A short name for this project, used to name resources"
  type        = string
  default     = "landing-zone"
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs before deletion"
  type        = number
  default     = 90
}