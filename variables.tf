variable "eventhub_name" {
  description = "The name of the Event Hub instance"
  type        = string
}

variable "namespace_name" {
  description = "The name of the Event Hub Namespace where the instance will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "partition_count" {
  description = "The number of partition for the Event Hub. Must be between 1 an 32."
  type        = number
  default     = 2

  validation {
    condition     = var.partition_count >= 1 && var.partition_count <= 32
    error_message = "The partition count must be between 1 and 32"
  }
}

variable "message_retention" {
  description = "Number of days to retain messages. Must be between 1 and 7."
  type        = number
  default     = 1
  validation {
    condition     = var.message_retention >= 1 && var.message_retention <= 7
    error_message = "The message_Retention must be between 1 and 7 days."
  }
}
