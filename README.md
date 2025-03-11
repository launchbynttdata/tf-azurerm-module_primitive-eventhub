<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | The name of the Event Hub instance | `string` | n/a | yes |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | The name of the Event Hub Namespace where the instance will be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name | `string` | n/a | yes |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | The number of partition for the Event Hub. Must be between 1 an 32. | `number` | `2` | no |
| <a name="input_message_retention"></a> [message\_retention](#input\_message\_retention) | Number of days to retain messages. Must be between 1 and 7. | `number` | `1` | no |
| <a name="input_status"></a> [status](#input\_status) | The status of the Event Hub. Possible values: Active, Disabled. | `string` | `"Active"` | no |
| <a name="input_capture_description"></a> [capture\_description](#input\_capture\_description) | Capture Configuration for Event Hub | <pre>object({<br/>    enabled             = bool<br/>    encoding            = string<br/>    interval_in_seconds = number<br/>    size_limit_in_bytes = number<br/>    destination = object({<br/>      name                = string<br/>      blob_container_name = string<br/>      archive_name_format = string<br/>      storage_account_id  = string<br/>    })<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_id"></a> [eventhub\_id](#output\_eventhub\_id) | The ID of the Event Hub instance |
| <a name="output_eventhub_name"></a> [eventhub\_name](#output\_eventhub\_name) | The name of the Event Hub instance |
| <a name="output_status"></a> [status](#output\_status) | The status of the Event Hub |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
