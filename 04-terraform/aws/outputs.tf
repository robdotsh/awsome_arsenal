# outputs.tf
output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.user_updates.arn
}

output "sns_topic_name" {
  description = "The name of the SNS topic"
  value       = aws_sns_topic.user_updates.name
}

output "service_name" {
  description = "Output Service Name"
  value       = var.service
}

output "service_owner" {
  description = "Output Service Owner"
  value       = var.owner
}
