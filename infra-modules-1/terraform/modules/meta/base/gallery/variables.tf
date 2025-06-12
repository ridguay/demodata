variable "gallery_name" {
  description = "Name of the VM Application Gallery"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the VM App Gallery"
  type        = string
  default     = "West Europe"
}

variable "tags" {
  description = "Tags to assign to Storage Account instance"
  type        = map(string)
  default     = {}
}
