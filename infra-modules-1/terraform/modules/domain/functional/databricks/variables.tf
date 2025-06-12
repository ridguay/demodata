### VARIABLES FOR WORKSPACE CONFIG ###
variable "workspace_config__nn_pypi_index_url" {
  description = "NN PyPI index url, including personal access token "
  type        = string # e.g. https://artifactory.insim.biz/artifactory/api/pypi/nn-pypi/simple
  sensitive   = true
  default     = "https://artifactory.insim.biz/artifactory/api/pypi/nn-pypi/simple"
  # If you run into authentication issues, please the same token for both indices. It's likely that the packaged pip version is out of date. Multi-credential support is available as of pip 21.2 https://github.com/pypa/pip/pull/10033
}

variable "workspace_config__nn_customer_pypi_index_url" {
  description = "Additional NN PyPI index url that contains customer-specific packages, including personal access token"
  type        = string # e.g. https://artifactory.insim.biz/artifactory/api/pypi/nndap-pypi/simple"
  sensitive   = true
  default     = "https://artifactory.insim.biz/artifactory/api/pypi/nndap-pypi/simple"
  # If you run into authentication issues, please use the same token for both indices. It's likely that the packaged pip version is out of date. Multi-credential support is available as of pip 21.2 https://github.com/pypa/pip/pull/10033
}

variable "workspace_config__kafka_secret" {
  description = "Name of the Kafka secret to retreve from the meta key vault"
  type        = string
  sensitive   = true
}

### Variables for Notebook Mounting Secrets ### 
variable "notebook_mounting_secret_scope" {
  description = "Scope that gets created to save the secrets in."
  type        = string
}

variable "notebook_mounting_secrets" {
  description = "Secrets to create in the scope (key = secret key, value = secret value)."
  type        = map(string)
}

### Variables for LEGACY Clusters ###
variable "legacy_cluster__names" {
  description = "Names of the Databricks clusters (creates a separate cluster for each name specified)"
  type        = list(string)
}

variable "legacy_user_specific_cluster__names" {
  description = "Names of the user-specific Databricks clusters (creates a separate cluster for each name specified)"
  type        = list(string)
}

variable "legacy_cluster__spark_version_id" {
  description = "Preloaded runtime version of Databricks cluster instance"
  type        = string
  default     = "10.4.x-scala2.12" # Defaults to Spark 3.0.1 using Scala 2.12.
}

variable "legacy_cluster__pypi_packages" {
  description = "List of packages to install on the cluster, each item should have the format 'package==x.x.x'."
  type        = list(string)
  default     = []
}

### Variables for Primary Cluster(s) ###
variable "cluster__unity_catalog_volume_name" {
  description = "Name of the Unity Catalog volumne."
  type        = string
}

variable "cluster__unity_catalog_volume_storage_account_name" {
  description = "Name of the storage account that contains the unity catalog volume."
  type        = string
}

variable "cluster__unity_catalog_volume_storage_container_name" {
  description = "Name of the volume storage container that contains the unity catalog volume."
  type        = string
}

variable "cluster__names" {
  description = "Names of the Databricks Unity Catalog enabled clusters (creates a separate cluster for each name specified)"
  type        = list(string)
}

variable "cluster__spark_version_id" {
  description = "Preloaded runtime version of Databricks cluster instance"
  type        = string
  default     = "10.4.x-scala2.12" # Defaults to Spark 3.0.1 using Scala 2.12. #TODO: UC Version
}

variable "cluster__node_type_id" {
  description = "Node type ID of Databricks cluster instance"
  type        = string
}

variable "cluster__autoterminate_after_minutes" {
  description = "Number of minutes after which the cluster automatically terminates"
  type        = number
  default     = 120
}

variable "cluster__tags" {
  description = "Mapping of tags to assign to the Databricks cluster instance"
  type        = map(string)
  default     = null
}

variable "cluster__minimum_workers" {
  description = "Minimal amount of workers within the cluster"
  type        = number
}

variable "cluster__maximum_workers" {
  description = "Maximum amount of workers within the cluster"
  type        = number
}

variable "cluster__extra_spark_configuration" {
  description = "Extra spark configuration the cluster should have"
  type        = map(string)
  default     = {}
}

variable "cluster__pypi_packages" {
  description = "List of packages to install on the cluster, each item should have the format 'package==x.x.x'."
  type        = list(string)
  default     = []
}

variable "cluster__runtime_engine" {
  description = "The type of runtime engine to use. If not specified, the runtime engine type is inferred based on the spark_version value."
  type        = string
  default     = "STANDARD"
}

### Variables for User-Specific Clusters ###
variable "user_specific_cluster__names" {
  description = "Names of the Databricks Unity Catalog enabled clusters (creates a separate cluster for each name specified)"
  type        = list(string)
}

variable "user_specific_cluster__spark_version_id" {
  description = "Preloaded runtime version of Databricks cluster instance"
  type        = string
  default     = "10.4.x-scala2.12" # Defaults to Spark 3.0.1 using Scala 2.12.
}

variable "user_specific_cluster__node_type_id" {
  description = "Node type ID of Databricks cluster instance"
  type        = string
}

variable "user_specific_cluster__autoterminate_after_minutes" {
  description = "Number of minutes after which the cluster automatically terminates"
  type        = number
  default     = 120
}

variable "user_specific_cluster__tags" {
  description = "Mapping of tags to assign to the Databricks cluster instance"
  type        = map(string)
  default     = null
}

variable "user_specific_cluster__minimum_workers" {
  description = "Minimal amount of workers within the cluster"
  type        = number
}

variable "user_specific_cluster__maximum_workers" {
  description = "Maximum amount of workers within the cluster"
  type        = number
}

variable "user_specific_cluster__extra_spark_configuration" {
  description = "Extra spark configuration the cluster should have"
  type        = map(string)
  default     = {}
}

### Variables for Databricks Asset Bundle Secrets ###
variable "meta_key_vault_id" {
  description = "The ID of the meta key vault"
  type        = string
}

variable "workspace_url" {
  description = "The Databricks workspace URL"
  type        = string
  default     = ""
}

variable "env_domain" {
  description = "The env-domain combination."
  type        = string
  default     = ""
}

### Variables for the service principals ###
variable "service_principal_configuration_iam" {
  description = "service principal list based on application_id + cluster_id to make it unique. \n Example: tomap({ '42e2bbc2-4562-4982-a537-0efdd2735e73' = {     \n 'cluster_ids' = tolist([ \n  '0209-110110-evou14ef', ]) \n 'display_name' = 'LPDAP-HANA-IND-REC' }}) "
  type = object({
    name           = string
    application_id = string

  })
}

variable "cluster__uc_enabled" {
  description = "Flag to deploy UC resources"
  type        = bool
  default     = true
}

variable "cluster__legacy_clusters_enabled" {
  description = "Flag to deploy legacy clusters"
  type        = bool
  default     = true
}

variable "unity_catalog_group_name" {
  description = "Entra group name for unity catalog schema / volume"
  type        = string
  default     = ""
}

variable "unity_catalog_sp_name" {
  description = "Service Principal name for unity catalog schema / volume"
  type        = string
  default     = ""
}
