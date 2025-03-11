// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
  status              = var.status

  dynamic "capture_description" {
    for_each = var.capture_description != null ? [1] : []
    content {
      enabled             = var.capture_description.enabled
      encoding            = var.capture_description.encoding
      interval_in_seconds = var.capture_description.interval_in_seconds
      size_limit_in_bytes = var.capture_description.size_limit_in_bytes

      destination {
        name                = var.capture_description.destination.name
        blob_container_name = var.capture_description.destination.blob_container_name
        archive_name_format = var.capture_description.destination.archive_name_format
        storage_account_id  = var.capture_description.destination.storage_account_id
      }
    }
  }
}
