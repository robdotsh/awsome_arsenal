# Create the SNS topic
resource "aws_sns_topic" "user_updates" {
  name              = var.sns_topic_name
  kms_master_key_id = var.kms_key_id

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": ${var.delivery_policy_max_receives_per_second}
    }
  }
}
EOF

  tags = var.tags
}

# Create an IAM policy to allow publishing to the SNS topic
resource "aws_iam_policy" "sns_publish_policy" {
  name        = var.sns_publish_policy_name
  description = "Allow publishing messages to the user-updates SNS topic"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sns:Publish"
        Resource = aws_sns_topic.user_updates.arn
      }
    ]
  })
}

# Attach the policy to a specific IAM role
resource "aws_iam_role_policy_attachment" "sns_publish_role_attachment" {
  policy_arn = aws_iam_policy.sns_publish_policy.arn
  role       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.sns_publish_role}"
}

# Create a Dead Letter Queue (DLQ) for failed message deliveries
resource "aws_sqs_queue" "sns_dlq" {
  name = var.sqs_dlq_name

  kms_master_key_id = var.kms_key_id
}

# Attach the Dead Letter Queue to the SNS Topic
resource "aws_sns_topic_subscription" "dlq_subscription" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = var.sqs_protocol
  endpoint  = aws_sqs_queue.sns_dlq.arn

  # Enable the DLQ for failed messages
  raw_message_delivery = var.raw_message_delivery
}

# CloudWatch Metric Filter for Monitoring SNS Activity
resource "aws_cloudwatch_log_group" "sns_log_group" {
  name = var.cloudwatch_log_group_name
}

resource "aws_cloudwatch_log_stream" "sns_log_stream" {
  log_group_name = aws_cloudwatch_log_group.sns_log_group.name
  name           = var.cloudwatch_log_stream_name
}

resource "aws_cloudwatch_metric_alarm" "sns_delivery_failures" {
  alarm_name          = var.sns_alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.sns_alarm_evaluation_periods
  metric_name         = "DeliveryFailures"
  namespace           = "AWS/SNS"
  period              = var.sns_alarm_period
  statistic           = "Sum"
  threshold           = var.sns_alarm_threshold

  alarm_actions = [
    "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:${var.alert_topic_name}"
  ]

  dimensions = {
    TopicName = aws_sns_topic.user_updates.name
  }

  tags = merge(var.tags, {
    "CreatedAt" = timestamp()
  })
}
