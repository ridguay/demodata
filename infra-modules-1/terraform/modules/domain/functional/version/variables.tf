variable "storage_account_name" {
  description = "Storage account (metatfstate) to deploy the version blob to."
  type        = string
  default     = "West Europe"
}

variable "storage_container_name" {
  description = "Storage container to deploy the version blob to."
  type        = string
  default     = "West Europe"
}

variable "blob_folder" {
  description = "Folder in which the version.txt blob should be placed."
  type        = string
}

variable "infra_modules_version" {
  description = "Version number of the infra-modules artifact we are deploying."
  type        = string
}
