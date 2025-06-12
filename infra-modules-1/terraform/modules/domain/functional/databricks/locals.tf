locals {
  ### LOCALS FOR WORKSPACE CONFIG ###
  certificates = {
    for file_name in fileset("${abspath(path.module)}/artifactory-init-scripts-legacy/certificates", "*.zip") : file_name => "${abspath(path.module)}/artifactory-init-scripts-legacy/certificates/${file_name}"
  }

  ### LOCALS FOR LEGACY CLUSTERS ###
  dbfs_packages = {
    for file_name in fileset("${abspath(path.module)}/packages", "*.jar") : file_name => "${abspath(path.module)}/packages/${file_name}"
  }

  # These loop over the input variable 'cluster__cluster_names' and 'cluster__pypi_packages' and reference the deployed resources later in the process.
  # When we referenced the resources in these locals, Terraform raised an error when running a plan against an empty platform.
  # Now the keys (and indices) are stored, and during deployment of the resources (the installation of the packages), the required values are retrieved.
  legacy_cluster_pypi_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.legacy_cluster__names :
    [
      for package in var.legacy_cluster__pypi_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        package      = package
      }
    ]
  ])

  legacy_cluster_dbfs_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.legacy_cluster__names :
    [
      for package_file_name, package_abspath in local.dbfs_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        file_name    = package_file_name # Key of the package in the databricks_dbfs_file.dbfs_packages deployment
      }
    ]
  ])

  legacy_user_specific_cluster_pypi_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.legacy_user_specific_cluster__names :
    [
      for package in var.legacy_cluster__pypi_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        package      = package
      }
    ]
  ])

  legacy_user_specific_cluster_dbfs_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.legacy_user_specific_cluster__names :
    [
      for package_file_name, package_abspath in local.dbfs_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        file_name    = package_file_name # Key of the package in the databricks_dbfs_file.dbfs_packages deployment
      }
    ]
  ])

  ### LOCALS FOR CLUSTERS (UNITY CATALOG) ###
  uc_init_scripts_folder = "${abspath(path.module)}/artifactory-init-scripts"
  uc_zip_files           = fileset(local.uc_init_scripts_folder, "**/*.zip")
  uc_script_files        = fileset(local.uc_init_scripts_folder, "*.tpl")
  uc_init_script_files = [
    for file in local.uc_script_files :
    {
      path     = "${local.uc_init_scripts_folder}/${file}",
      filename = file
    }
  ]
  uc_init_zip_files = [
    for file in local.uc_zip_files :
    {
      path     = "${local.uc_init_scripts_folder}/${file}",
      filename = file
    }
  ]
  # Convert init_script_files tuple to a map
  uc_init_script_files_map      = toset([for file in local.uc_init_script_files : file.path])
  uc_init_zip_files_map         = toset([for file in local.uc_init_zip_files : file.path])
  uc_init_script_path_file_name = "/Volumes/${var.cluster__unity_catalog_volume_name}/lpdap_databricks_cluster/cluster_packages/artifactory-init-scripts/artifactory_init.sh"

  jar_folder = "${abspath(path.module)}/packages"
  jar_packages = [
    for file in fileset(local.jar_folder, "*.jar") :
    {
      path     = "${local.jar_folder}/${file}",
      filename = file
    }
  ]
  jar_packages_map = toset([for jar in local.jar_packages : jar.path])

  cluster_pypi_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.cluster__names :
    [
      for package in var.cluster__pypi_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        package      = package
      }
    ]
  ])

  cluster_jar_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.cluster__names :
    [
      for jar in local.jar_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        file_name    = jar.filename
        destination  = "/Volumes/${var.cluster__unity_catalog_volume_name}/lpdap_databricks_cluster/cluster_packages/packages/${jar.filename}"
      }
    ]
  ])

  user_specific_cluster_pypi_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.user_specific_cluster__names :
    [
      for package in var.cluster__pypi_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        package      = package
      }
    ]
  ])

  user_specific_cluster_jar_package_install_configuration = flatten([
    for deploy_index, cluster_name in var.user_specific_cluster__names :
    [
      for jar in local.jar_packages :
      {
        deploy_index = deploy_index # Index of the cluster in the databricks_cluster.dbc deployment
        cluster_name = cluster_name
        file_name    = jar.filename
        destination  = "/Volumes/${var.cluster__unity_catalog_volume_name}/lpdap_databricks_cluster/cluster_packages/packages/${jar.filename}"
      }
    ]
  ])
}

locals {
  ### LOCALS FOR SERVICE PRINCIPAL ###

  legacy_cluster_ids = merge(
    { for cluster in databricks_cluster.legacy_dbc : cluster.cluster_name => { "name" : cluster.cluster_name, "id" : cluster.id } },
    { for cluster in databricks_cluster.legacy_dbc_user_specific : cluster.cluster_name => { "name" : cluster.cluster_name, "id" : cluster.id } }
  )
  cluster_ids = merge(
    { for cluster in databricks_cluster.dbc : cluster.cluster_name => { "name" : cluster.cluster_name, "id" : cluster.id } },
    { for cluster in databricks_cluster.dbc_user_specific : cluster.cluster_name => { "name" : cluster.cluster_name, "id" : cluster.id } }
  )

  legacy_cluster_data = var.cluster__legacy_clusters_enabled ? [local.legacy_cluster_ids["cluster_load"]] : []
  uc_cluster_data     = var.cluster__uc_enabled ? [local.cluster_ids["cluster_main"]] : []
  cluster_data        = tomap({ "cluster_data" : concat(local.legacy_cluster_data, local.uc_cluster_data) })

  ### LOCALS FOR DAB SECRETS ###
  dab_secrets = {
    "${var.env_domain}-databricks-workspace-host" = "${var.workspace_url}"
    "${var.env_domain}-databricks-workspace-pat"  = "${databricks_token.pat.token_value}"
  }
  secret_names = [for name, value in local.dab_secrets : "${name}"]
}
