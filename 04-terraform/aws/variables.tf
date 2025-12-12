# variables.tf

variable "region" {
  type        = string
  description = "The AWS region to deploy resources"
  default     = "eu-west-1"
}

variable "profile" {
  type        = string
  description = "The AWS profile to use for authentication"
  default     = "default"
}

variable "CostCenter" {
  type        = string
  description = "The cost center associated with the resources"
  default     = "CC1234"
}

variable "environment" {
  type        = string
  description = "The environment the resources belong to (e.g., 'dev', 'prod')"
  default     = "tooling"
}

variable "owner" {
  type        = string
  description = "The owner or team responsible for the resources"
  default     = "DevOps-Tools"
}

variable "service" {
  type        = string
  description = "The service name or identifier for these resources"
  default     = "DevOps-Tools"
}

variable "tags" {
  type        = map(string)
  description = "A map of additional custom tags to apply to resources"
  default = {
    ManagedBy = "Terraform"
    CreatedBy = "Terraform"
  }
}

variable "sns_topic_name" {
  type        = string
  description = "The name of the SNS topic"
  default     = "user-updates-topic"
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key to use for SNS topic encryption"
  default     = "alias/aws/sns"
}

variable "sns_publish_role" {
  type        = string
  description = "The IAM role that is allowed to publish"
  default     = "SpecialPublishRole"
}

variable "alert_topic_name" {
  type        = string
  description = "The name of the SNS topic to receive alerts"
  default     = "this-alert-topic"
}

variable "delivery_policy_max_receives_per_second" {
  type        = number
  description = "Maximum number of messages the SNS topic can receive per second"
  default     = 1
}

variable "sns_publish_policy_name" {
  type        = string
  description = "The name of the SNS publish policy"
  default     = "SNSPublishPolicy"
}

variable "sqs_dlq_name" {
  type        = string
  description = "The name of the Dead Letter Queue (DLQ)"
  default     = "sns-dlq-user-updates"
}

variable "sqs_protocol" {
  type        = string
  description = "The protocol for the SNS subscription"
  default     = "sqs"
}

variable "raw_message_delivery" {
  type        = bool
  description = "Whether to enable raw message delivery for the DLQ"
  default     = true
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group"
  default     = "/aws/sns/user-updates-logs"
}

variable "cloudwatch_log_stream_name" {
  type        = string
  description = "The name of the CloudWatch log stream"
  default     = "user-updates-stream"
}

variable "sns_alarm_name" {
  type        = string
  description = "The name of the SNS alarm"
  default     = "sns_delivery_failures"
}

variable "sns_alarm_evaluation_periods" {
  type        = number
  description = "The number of periods over which data is evaluated for the alarm"
  default     = 1
}

variable "sns_alarm_period" {
  type        = number
  description = "The time in seconds over which the metric is evaluated"
  default     = 60
}

variable "sns_alarm_threshold" {
  type        = number
  description = "The threshold for triggering the alarm"
  default     = 1
}
