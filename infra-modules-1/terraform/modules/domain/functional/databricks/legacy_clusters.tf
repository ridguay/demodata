### LEGACY CLUSTERS THAT ARE NOT UC-ENABLED ###

### Packages for Legacy Clusters ###
resource "databricks_dbfs_file" "legacy_dbfs_packages" {
  for_each = local.dbfs_packages
  source   = each.value
  path     = "/packages/${each.key}"
}

### Cluster Load ###
resource "databricks_cluster" "legacy_dbc" {
  count = length(var.legacy_cluster__names)

  cluster_name                 = var.legacy_cluster__names[count.index]
  spark_version                = var.legacy_cluster__spark_version_id
  node_type_id                 = var.cluster__node_type_id
  autotermination_minutes      = var.cluster__autoterminate_after_minutes
  custom_tags                  = var.cluster__tags
  is_pinned                    = true
  enable_local_disk_encryption = true
  autoscale {
    min_workers = var.cluster__minimum_workers
    max_workers = var.cluster__maximum_workers
  }

  spark_conf = merge({
    "spark.databricks.delta.properties.defaults.enableChangeDataFeed" : true,
    "spark.databricks.delta.preview.enabled" : true,
    "spark.sql.legacy.parquet.int96RebaseModeInRead" : "CORRECTED"
  }, var.cluster__extra_spark_configuration)

  spark_env_vars = {
    "PYSPARK_PYTHON" : "/databricks/python3/bin/python3",
    "KAFKA_CERT" : "{{secrets/ibm_kafka_scope/kafka_certificate}}"
  }

  cluster_log_conf {
    dbfs {
      destination = "dbfs:/FileStore/cluster-logs"
    }
  }

  depends_on = [databricks_secret.kafka_certificate, databricks_global_init_script.artifactory_init_script]
}

resource "databricks_library" "legacy_pypi_packages_user_specific" {
  # Transform the list into a mapping to prevent unneeded destroys when the indexing changes
  for_each = { for o in local.legacy_cluster_pypi_package_install_configuration : "${o.cluster_name}_${o.package}" => o }

  cluster_id = databricks_cluster.legacy_dbc[each.value.deploy_index].id
  pypi {
    package = each.value.package
  }

  depends_on = [databricks_cluster.legacy_dbc]
}

resource "databricks_library" "legacy_dbfs_packages" {
  for_each = { for o in local.legacy_cluster_dbfs_package_install_configuration : "${o.cluster_name}_${databricks_dbfs_file.legacy_dbfs_packages[o.file_name].md5}" => o }

  cluster_id = databricks_cluster.legacy_dbc[each.value.deploy_index].id
  jar        = databricks_dbfs_file.legacy_dbfs_packages[each.value.file_name].dbfs_path

  depends_on = [databricks_cluster.legacy_dbc, databricks_dbfs_file.legacy_dbfs_packages]
}


### User Specific Clusters ###
resource "databricks_cluster" "legacy_dbc_user_specific" {
  count = length(var.legacy_user_specific_cluster__names)

  cluster_name                 = var.legacy_user_specific_cluster__names[count.index]
  spark_version                = var.legacy_cluster__spark_version_id
  node_type_id                 = var.user_specific_cluster__node_type_id
  autotermination_minutes      = var.user_specific_cluster__autoterminate_after_minutes
  custom_tags                  = var.user_specific_cluster__tags
  is_pinned                    = true
  enable_local_disk_encryption = true
  autoscale {
    min_workers = var.user_specific_cluster__minimum_workers
    max_workers = var.user_specific_cluster__maximum_workers
  }

  spark_conf = merge({
    "spark.databricks.delta.properties.defaults.enableChangeDataFeed" : true,
    "spark.databricks.delta.preview.enabled" : true,
    "spark.sql.legacy.parquet.int96RebaseModeInRead" : "CORRECTED"
  }, var.user_specific_cluster__extra_spark_configuration)

  spark_env_vars = {
    "PYSPARK_PYTHON" : "/databricks/python3/bin/python3",
    "KAFKA_CERT" : "{{secrets/ibm_kafka_scope/kafka_certificate}}"
  }

  cluster_log_conf {
    dbfs {
      destination = "dbfs:/FileStore/cluster-logs"
    }
  }

  depends_on = [databricks_secret.kafka_certificate, databricks_global_init_script.artifactory_init_script]
}

resource "databricks_library" "legacy_user_specific_pypi_packages" {
  # Transform the list into a mapping to prevent unneeded destroys when the indexing changes
  for_each = { for o in local.legacy_user_specific_cluster_pypi_package_install_configuration : "${o.cluster_name}_${o.package}" => o }

  cluster_id = databricks_cluster.legacy_dbc_user_specific[each.value.deploy_index].id
  pypi {
    package = each.value.package
  }

  depends_on = [databricks_cluster.legacy_dbc]
}

resource "databricks_library" "legacy_user_specific_dbfs_packages" {
  for_each = { for o in local.legacy_user_specific_cluster_dbfs_package_install_configuration : "${o.cluster_name}_${databricks_dbfs_file.legacy_dbfs_packages[o.file_name].md5}" => o }

  cluster_id = databricks_cluster.legacy_dbc_user_specific[each.value.deploy_index].id
  jar        = databricks_dbfs_file.legacy_dbfs_packages[each.value.file_name].dbfs_path

  depends_on = [databricks_cluster.legacy_dbc_user_specific, databricks_dbfs_file.legacy_dbfs_packages]
}
