variable "gallery_id" {
  description = "ID of the Azure Gallery"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account in which the driver files reside."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container in which the VM Apps should be stored."
  type        = string
}

variable "connection_string" {
  description = "Connection string needed to connect to the storage account."
  type        = string
  sensitive   = true
}

variable "ibm_db2_driver_vars" {
  type = object({
    file_name       = string
    output_path     = string
    app_name        = string
    app_version     = string
    source_path     = string
    app_install_cmd = string
    app_remove_cmd  = string
  })
}

variable "java_jre_vars" {
  type = object({
    file_name       = string
    output_path     = string
    app_name        = string
    app_version     = string
    source_path     = string
    app_install_cmd = string
    app_remove_cmd  = string
  })
}

variable "sap_cdc_driver_vars" {
  type = object({
    file_name       = string
    output_path     = string
    app_name        = string
    app_version     = string
    source_path     = string
    app_install_cmd = string
    app_remove_cmd  = string
  })
}

variable "sap_hana_driver_vars" {
  type = object({
    file_name       = string
    output_path     = string
    app_name        = string
    app_version     = string
    source_path     = string
    app_install_cmd = string
    app_remove_cmd  = string
  })
}

variable "snow_findings_vars" {
  type = object({
    file_name       = string
    output_path     = string
    app_name        = string
    app_version     = string
    source_path     = string
    app_install_cmd = string
    app_remove_cmd  = string
  })
}

variable "integration_runtime_vars" {
  type = object({
    file_name       = string
    output_path     = string
    app_name        = string
    app_version     = string
    source_path     = string
    app_install_cmd = string
    app_remove_cmd  = string
  })
}


variable "key_vault_iam_role_assignments_vars" {
  type = object({
    key_vault_id         = string
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "key_vault_envs_role_assignments_vars" {
  type = object({
    key_vault_id         = string
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}

variable "databricks_role_assignments_vars" {
  type = object({
    workspace_id         = string
    user_principal_roles = optional(map(list(string)), {})
    principal_id_roles   = optional(map(list(string)), {})
  })
  default = null
}
