variable "storage_account_id" {
  description = "The ID of the storage account to which an Azure Managed Integration Runtime should be able to connect"
  type        = string
}

variable "managed_pe_name" {
  description = "The name of the ADF managed private endpoint"
  type        = string
}
