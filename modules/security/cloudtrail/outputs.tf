output "cloudtrail_bucket" {
  value = aws_s3_bucket.cloudtrail_logs.id
}

output "config_recorder_name" {
  value = aws_config_configuration_recorder.recorder.name
}

output "secrets_manager_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}