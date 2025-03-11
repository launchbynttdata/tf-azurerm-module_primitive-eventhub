variable "eventhub_name" {
  description = "The name of the Event Hub instance"
  type        = string
}

variable "namespace_name" {
  description = "The name of the Event Hub Namespace where the instance will be created"
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

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 90
    }
  }
}

variable "region" {
  type        = string
  description = <<EOF
    (Required) The location where the resource will be created. Must not have spaces
    For example, eastus, westus, centralus etc.
  EOF
  nullable    = false
  default     = "eastus2"

  validation {
    condition     = length(regexall("\\b \\b", var.region)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "network"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "sku" {
  description = "The sku for the eventhub namespace. Possible values: Basic, Standard, Premium"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The SKU must be of: Basic, Standard, Premium."
  }
}

variable "capacity" {
  description = <<EOT
  The capacity of the Event Hub Namespace:
  - Basic: 1
  - Standard: Between 1 and 20
  - Premium: Between 1 and 4
  EOT
  type        = number
  default     = 1

  validation {
    condition = (
      (var.sku == "Basic" && var.capacity == 1) ||
      (var.sku == "Standard" && var.capacity >= 1 && var.capacity <= 20) ||
      (var.sku == "Premium" && var.capacity >= 1 && var.capacity <= 4)
    )
    error_message = "The capacity must be 1 for Basic, between 1-20 for Standard, or between 1-4 for Premium"
  }

}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "location" {
  type = string
}
variable "status" {
  type    = string
  default = "Active"
}

variable "capture_description" {
  type = object({
    enabled             = bool
    encoding            = string
    interval_in_seconds = number
    size_limit_in_bytes = number
    destination = object({
      name                = string
      blob_container_name = string
      archive_name_format = string
      storage_account_id  = string
    })
  })
  default = null
}
