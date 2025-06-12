variable "output_path" {
  description = "output path for zip file"
  type        = string
}

variable "source_path" {
  description = "Folder containt the application files"
  type        = string
}

variable "app_name" {
  description = "The name of the VM app"
  type        = string
}

variable "app_version" {
  description = "the version number of the app"
  type        = string
}

variable "app_install_cmd" {
  description = "Command to install the application"
  type        = string
}

variable "app_remove_cmd" {
  description = "Command to remove the application"
  type        = string
}

variable "file_name" {
  description = "Filename of the zip file"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for VM Applications"
  type        = string
}

variable "container_name" {
  description = "Name of the container for VM Applications"
  type        = string
}

variable "connection_string" {
  description = "Connection String of the VM Applications Storage Account"
  type        = string
}

variable "location" {
  description = "The location of the resource"
  type        = string
  default     = "West Europe"
}

variable "gallery_id" {
  description = "The id of the image gallery for VM Applications"
  type        = string
}