output "terraform_state_bucket" {
  description = "The name of the s3 bucket storing Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "terraform_state_lock_table" {
  description = "The name of the DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_state.id
}