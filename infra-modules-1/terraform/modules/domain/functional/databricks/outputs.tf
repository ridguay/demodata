output "cluster_ids" {
  description = "Cluster IDs of the clusters created in this Databricks workspace."
  value = merge(
    { for cluster in databricks_cluster.dbc : cluster.cluster_name => cluster.id },
    { for cluster in databricks_cluster.legacy_dbc : cluster.cluster_name => cluster.id }
  )
}

output "user_specific_cluster_ids" {
  description = "Cluster IDs of the user specific clusters created in this Databricks workspace."
  value = merge(
    { for cluster in databricks_cluster.dbc_user_specific : cluster.cluster_name => cluster.id },
    { for cluster in databricks_cluster.legacy_dbc_user_specific : cluster.cluster_name => cluster.id }
  )
}
