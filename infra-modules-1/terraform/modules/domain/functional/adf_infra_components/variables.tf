### Variables Shared Across Modules ###
variable "data_factory_id" {
  description = "The Data Factory ID in which to associate the Linked Service. Changing this forces a new resource"
  type        = string
}

variable "integration_runtime_name" {
  description = "Name of the Self Hosted Integration Runtime used by the Databricks Linked Service."
  type        = string
}

variable "azure_integration_runtime_name" {
  description = "Name of the Azure hosted integration runtime"
  type        = string
}

### Databricks Linked Service Variables ###
variable "databricks_workspace_url" {
  description = "The domain URL of the databricks instance."
  type        = string
}

variable "databricks_workspace_id" {
  description = "Id of the Databricks Workspace to create the ADF Databricks Linked Service to"
  type        = string
}

variable "databricks_cluster_ids" {
  description = "A mapping of the cluster names to their ids of existing clusters within the Azure Databricks instance\nDefine exactly one of databricks_cluster_ids or pool_id"
  type        = map(string)
  default     = {}
}

variable "pool_id" {
  description = "Identifier of the instance pool within the linked Azure Databricks instance\nDefine exactly one of databricks_cluster_ids or pool_id"
  type        = string
  default     = null
}

variable "cluster_spark_version" {
  description = "Spark version of the clusters to be created within the pool\nOnly required when pool_id is specified"
  type        = string
  default     = "10.4.x-scala2.12"
}

### Key Vault Linked Service Variables ###
variable "key_vault_id" {
  description = "Id of the Key Vault instance to create the Linked Service to"
  type        = string
}

### Run SQL Query Pipeline Variables ###
variable "notebook_path" {
  description = "Path to the notebook uploaded to Databricks that can run the SQL query. Should start with / and end with .py"
  type        = string
}

### Start Stop VM Pipeline Variables ###
variable "subscription_id" {
  description = "Id of the subscription containing the virtual machine of the Self Hosted Integration Runtime"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group containing the Virtual Machine instance"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the virtual machine containing the Self Hosted Integration Runtime instance"
  type        = string
}

### Storage Connection Variables ###
variable "storage_account_primary_dfs_endpoint" {
  description = "Primary Distributed File System endpoint of the Storage Account instance which Azure Data Factory needs a Linked Service to"
  type        = string
}

variable "dataset_config" {
  description = "The configuration of the datasets to be created."
  type = list(object({
    dataset_name      = string
    container_name    = string
    file_type         = string
    compression_codec = string
    level             = optional(string)
  }))
}

### User Specific Clusters Linked Services Variables ###
variable "user_specific_cluster_ids" {
  description = "A mapping of the (user-specific) cluster names to their ids of existing clusters within the Azure Databricks workspace\nDefine exactly one of databricks_cluster_ids or pool_id"
  type        = map(string)
  default     = {}
}

variable "legacy_clusters_enabled" {
  description = "Flag to deploy legacy clusters linked services"
  type        = bool
  default     = true
}
