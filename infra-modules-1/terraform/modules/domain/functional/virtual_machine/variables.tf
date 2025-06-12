### Common Variables ###

variable "resource_group_name" {
  description = "The Resource Group name of the Data Factory instance"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the Data Factory instance"
  type        = map(string)
  default     = {}
}

### Virtual Machine ### 

variable "virtual_machine_name" {
  description = "Name for the VM"
  type        = string

  validation {
    condition     = length(var.virtual_machine_name) <= 15
    error_message = "Virtual machine name can be at most 15 characters."
  }
}

variable "virtual_machine_location" {
  description = "Location of Data Factory instance"
  type        = string
}

variable "virtual_machine_private_ip_address" {
  description = "IP Address for the VM"
  type        = string
}

variable "virtual_machine_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_D4_v4"
}

variable "virtual_machine_os_disk_storage_account_type" {
  description = "Storage type of the virtual machine"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "virtual_machine_os_disk_size_gb" {
  description = "Storage size of the virtual machine"
  type        = number
  default     = 127 # minimum size on standard SSDs
}

variable "virtual_machine_timezone" {
  description = "Time zone of the virtual machine"
  type        = string
  default     = "W. Europe Standard Time"
}

variable "virtual_machine_subnet_id" {
  description = "Subnet id for the virtual machine"
  type        = string # When deploying an High Available integration runtime, ensure that your subnet allows intra-subnet traffic on port 8060.
}

variable "virtual_machine_accelerated_networking" {
  description = "Accelerated networking performance"
  type        = bool
  default     = false
}

### Virtual Machine Extensions + Applications ###

variable "artifactory_password" {
  description = "Password to connect to artifactory, used in the vm_custom_data.ps1 script."
  type        = string
  sensitive   = true
}

variable "monitoring_agent_config" {
  description = "Monitoring agent configuration with a Log Analytics Workspace.\nAssociates the VM with a Log Analytics workspace."
  type = object({
    log_analytics_workspace_workspace_id = string
    log_analytics_workspace_auth_key     = string
  })
  sensitive = true
}

variable "diagnostics_storage_account_name" {
  description = "Virtual machine diagnostics settings for storage account"
  type        = string
  default     = null
}

variable "law_data_collection_rule_id" {
  description = "Log Analytics Data Collection Rule ID"
  type        = string
  default     = null
}

variable "vm_patch" {
  description = "VM patch configuration"
  type = object({
    schedule_name = string #"Name of the schedule"
    start_time    = string #"Start time of the schedule"
    start_date    = string #"Start date of the schedule"
    recur_every   = string #"Recurrence interval"
    duration      = string #"Duration of the patching"
  })
}

variable "shir_key_vault_uri" {
  description = "The URI for the SHIR key vault"
  type        = string
}

variable "shir_key_vault_id" {
  description = "The ID for the SHIR key vault"
  type        = string
}

variable "shir_authorization_key" {
  description = "Primary authorization key of the self-hosted integration runtime"
  type        = string
  sensitive   = true
}

variable "adf_private_endpoint_ip_address" {
  description = "Ip address of the private endpoint of Data Factory instance"
  type        = string
}

variable "adf_private_endpoint_fqdn" {
  description = "Fully Qualified Domain Name of the Data Factory instance"
  type        = string
}

variable "virtual_machine_application_ids" {
  description = "List of ids of VM Applications to add to the Virtual Machine"
  type        = list(string)
}
