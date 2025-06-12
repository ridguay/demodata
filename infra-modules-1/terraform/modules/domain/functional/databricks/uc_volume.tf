resource "databricks_schema" "uc_schema" {
  count = var.cluster__uc_enabled ? 1 : 0

  catalog_name = var.cluster__unity_catalog_volume_name
  name         = "lpdap_databricks_cluster"
  owner        = var.unity_catalog_sp_name
  comment      = "This schema includes the UC volume for LPDAP platform components"
  properties = {
  }
}

resource "databricks_volume" "uc_volume" {
  count = var.cluster__uc_enabled ? 1 : 0

  name             = "cluster_packages"
  catalog_name     = var.cluster__unity_catalog_volume_name
  owner            = var.unity_catalog_sp_name
  schema_name      = databricks_schema.uc_schema[0].name
  volume_type      = "EXTERNAL"
  storage_location = "abfss://${var.cluster__unity_catalog_volume_storage_container_name}@${var.cluster__unity_catalog_volume_storage_account_name}.dfs.core.windows.net/cluster_packages"
  # the path suffix /cluster_packages is essential for the volume to be created correctly 
  comment = "this volume is managed by terraform (LPDAP platform team)"
}

resource "databricks_grant" "uc_schema_permissions" {
  count = var.cluster__uc_enabled ? 1 : 0

  schema     = "${var.cluster__unity_catalog_volume_name}.${databricks_schema.uc_schema[0].name}"
  principal  = var.unity_catalog_group_name
  privileges = ["USE_SCHEMA", "READ VOLUME"]
  depends_on = [databricks_grant.uc_sp_permissions[0]]
}

resource "databricks_grant" "uc_sp_permissions" {
  count = var.cluster__uc_enabled ? 1 : 0

  schema     = "${var.cluster__unity_catalog_volume_name}.${databricks_schema.uc_schema[0].name}"
  principal  = var.unity_catalog_sp_name
  privileges = ["USE SCHEMA", "ALL PRIVILEGES", "MANAGE"]
}
