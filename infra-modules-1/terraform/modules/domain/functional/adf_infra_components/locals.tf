locals {
  all_cluster_ids = merge(var.databricks_cluster_ids, var.user_specific_cluster_ids)
}