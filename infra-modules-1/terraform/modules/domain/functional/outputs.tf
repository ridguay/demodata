output "databricks__cluster_ids" {
  description = "IDs of the (main) clusters"
  value       = try(module.databricks[0].cluster_ids, null)
}

output "databricks__user_specific_cluster_ids" {
  description = "IDs of the user specific clusters"
  value       = try(module.databricks[0].user_specific_cluster_ids, null)
}

output "data_factory__id" {
  description = "ID of the Data Factory instance"
  value       = try([for df in module.data_factory : df.id], null)
}

output "data_factory__shir_name" {
  description = "The name of the Self-Hosted Integration Runtime"
  value       = try([for df in module.data_factory : df.shir_name], null)
}
