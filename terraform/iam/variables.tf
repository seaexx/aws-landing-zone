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

variable "github_org" {
  description = "The GitHub organization or the username that owns the repository"
  type        = string
  default     = "seaexx"
}

variable "github_repo" {
  description = "The GitHub repository name that GitHub Actions will deploy from"
  type        = string
  default     = "aws-landing-zone"
}