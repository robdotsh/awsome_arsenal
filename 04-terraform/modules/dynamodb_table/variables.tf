variable "table_name" {
  type        = string
  description = "DynamoDB table name (must be unique within the AWS region)"
  default     = "job_interview"
}

variable "hash_key" {
  type        = string
  description = "Attribute name used as the table or index partition (hash) key"
  default     = "UserId"
}

variable "hash_key_type" {
  type        = string
  description = "DynamoDB attribute type for the hash key (S = string, N = number, B = binary)"
  default     = "S"
}

variable "tags" {
  type        = map(string)
  description = "Key-value tags to apply to the DynamoDB table"
  default     = {}
}

variable "dynamodb_billing_mode" {
  type        = string
  description = "DynamoDB billing mode (PAY_PER_REQUEST for on-demand, PROVISIONED for fixed capacity)"
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_read_capacity" {
  type        = number
  description = "Read capacity units (only used if PROVISIONED)"
  default     = 1
}

variable "dynamodb_write_capacity" {
  type        = number
  description = "Write capacity units (only used if PROVISIONED)"
  default     = 1
}

variable "dynamodb_estimated_item_size_bytes" {
  type        = number
  description = "Average item size in bytes (for planning)"
  default     = 512
}

variable "dynamodb_estimated_item_count" {
  type        = number
  description = "Expected maximum number of items under free-tier usage"
  default     = 10000
}
