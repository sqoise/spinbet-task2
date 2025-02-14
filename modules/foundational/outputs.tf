output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  description = "List of Private Subnet IDs"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "security_group_ids" {
  value = { for k, v in aws_security_group.sg : k => v.id }
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}