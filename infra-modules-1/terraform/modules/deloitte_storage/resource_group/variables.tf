variable "name" {
  description = "Name of the Resource Group instance"
  type        = string
}

variable "location" {
  description = "Location of the Resource Group instance"
  type        = string
  default     = "West Europe"
}

variable "tags" {
  description = "Tags to assign to the Resource Group"
  type        = map(string)
  default     = {}
}
