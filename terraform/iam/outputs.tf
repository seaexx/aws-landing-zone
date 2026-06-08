output "github_actions_role_arn" {
  description = "The ARN of the GitHub Actions IAM role"
  value       = aws_iam_role.github_actions.arn
}

output "devops_engineer_role_arn" {
  description = "The ARN of the DevOps Engineer IAM role"
  value       = aws_iam_role.devops_engineer.arn
}

output "read_only_role_arn" {
  description = "The ARN of the Read Only IAM role"
  value       = aws_iam_role.read_only.arn
}