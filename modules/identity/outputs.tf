output "secrets_manager_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}

output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}