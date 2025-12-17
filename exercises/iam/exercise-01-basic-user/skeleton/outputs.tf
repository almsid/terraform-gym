# Outputs for Exercise 01

# TODO: Add outputs for user details
# Mark access key outputs as sensitive!

output "user_name" {
  description = "IAM username"
  value       = aws_iam_user.exercise_user.id
}

output "user_arn" {
  description = "IAM user ARN"
  value       = aws_iam_user.exercise_user.arn
}

output "access_key_id" {
  description = "Access key ID (sensitive)"
  value       = aws_iam_access_key.user_key.id
  sensitive   = true
}

output "secret_access_key" {
  description = "Secret access key (sensitive)"
  value       = aws_iam_access_key.user_key.secret
  sensitive   = true
}
