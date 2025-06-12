# Process the template file
data "template_file" "uc_init_script" {
  template = file("${abspath(path.module)}/artifactory-init-scripts/artifactory_init.sh.tpl")
  vars = {
    index_url          = var.workspace_config__nn_pypi_index_url
    extra_index_url    = var.workspace_config__nn_customer_pypi_index_url
    unity_catalog_name = var.cluster__unity_catalog_volume_name
  }
}

resource "azurerm_storage_blob" "uc_init_zip_files" {
  for_each = var.cluster__uc_enabled ? local.uc_init_zip_files_map : []

  name                   = "cluster_packages/artifactory-init-scripts/certificates/${basename(each.value)}"
  storage_account_name   = var.cluster__unity_catalog_volume_storage_account_name
  storage_container_name = var.cluster__unity_catalog_volume_storage_container_name
  type                   = "Block"
  source                 = each.value
}

resource "azurerm_storage_blob" "uc_init_script" {
  count = var.cluster__uc_enabled ? 1 : 0

  name                   = "cluster_packages/artifactory-init-scripts/artifactory_init.sh"
  storage_account_name   = var.cluster__unity_catalog_volume_storage_account_name
  storage_container_name = var.cluster__unity_catalog_volume_storage_container_name
  type                   = "Block"
  source_content         = data.template_file.uc_init_script.rendered
  depends_on = [
    data.template_file.uc_init_script,
    azurerm_storage_blob.uc_init_zip_files
  ]
}


resource "azurerm_storage_blob" "uc_packages" {
  for_each = var.cluster__uc_enabled ? local.jar_packages_map : []

  name                   = "cluster_packages/packages/${basename(each.value)}"
  storage_account_name   = var.cluster__unity_catalog_volume_storage_account_name
  storage_container_name = var.cluster__unity_catalog_volume_storage_container_name
  type                   = "Block"
  source                 = each.value
}


resource "databricks_cluster" "dbc" {
  count = var.cluster__uc_enabled ? length(var.cluster__names) : 0

  cluster_name                 = var.cluster__names[count.index]
  spark_version                = var.cluster__spark_version_id
  node_type_id                 = var.cluster__node_type_id
  autotermination_minutes      = var.cluster__autoterminate_after_minutes
  custom_tags                  = var.cluster__tags
  is_pinned                    = true
  enable_local_disk_encryption = true
  data_security_mode           = "USER_ISOLATION"
  runtime_engine               = var.cluster__runtime_engine
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
  init_scripts {
    volumes {
      destination = local.uc_init_script_path_file_name
    }
  }

  depends_on = [
    azurerm_storage_blob.uc_init_script,
    databricks_secret.kafka_certificate
  ]
}

resource "databricks_library" "pypi_packages" {
  # Transform the list into a mapping to prevent unneeded destroys when the indexing changes
  for_each = var.cluster__uc_enabled ? { for o in local.cluster_pypi_package_install_configuration : "${o.cluster_name}_${o.package}" => o } : {}

  cluster_id = databricks_cluster.dbc[each.value.deploy_index].id
  pypi {
    package = each.value.package
  }
  depends_on = [databricks_cluster.dbc]
}

resource "databricks_library" "uc_storage_packages" {
  for_each = var.cluster__uc_enabled ? { for o in local.cluster_jar_package_install_configuration : "${o.cluster_name}_${o.file_name}" => o } : {}

  cluster_id = databricks_cluster.dbc[each.value.deploy_index].id
  jar        = each.value.destination

  depends_on = [
    azurerm_storage_blob.uc_packages,
    databricks_cluster.dbc
  ]
}

### User-Specific Clusters ###
resource "databricks_cluster" "dbc_user_specific" {
  count = var.cluster__uc_enabled ? length(var.user_specific_cluster__names) : 0

  cluster_name                 = var.user_specific_cluster__names[count.index]
  spark_version                = var.cluster__spark_version_id #var.user_specific_cluster__spark_version_id
  node_type_id                 = var.user_specific_cluster__node_type_id
  autotermination_minutes      = var.user_specific_cluster__autoterminate_after_minutes
  custom_tags                  = var.user_specific_cluster__tags
  is_pinned                    = true
  enable_local_disk_encryption = true
  data_security_mode           = "USER_ISOLATION"
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
  init_scripts {
    volumes {
      destination = local.uc_init_script_path_file_name
    }
  }

  depends_on = [azurerm_storage_blob.uc_init_script, databricks_secret.kafka_certificate]
}

resource "databricks_library" "user_specific_pypi_packages" {
  # Transform the list into a mapping to prevent unneeded destroys when the indexing changes
  for_each = var.cluster__uc_enabled ? { for o in local.user_specific_cluster_pypi_package_install_configuration : "${o.cluster_name}_${o.package}" => o } : {}

  cluster_id = databricks_cluster.dbc_user_specific[each.value.deploy_index].id
  pypi {
    package = each.value.package
  }
  depends_on = [databricks_cluster.dbc_user_specific]
}

resource "databricks_library" "user_specific_storage_packages" {
  for_each = var.cluster__uc_enabled ? { for o in local.user_specific_cluster_jar_package_install_configuration : "${o.cluster_name}_${o.file_name}" => o } : {}

  cluster_id = databricks_cluster.dbc_user_specific[each.value.deploy_index].id
  jar        = each.value.destination

  depends_on = [
    azurerm_storage_blob.uc_packages,
    databricks_cluster.dbc_user_specific
  ]
}
