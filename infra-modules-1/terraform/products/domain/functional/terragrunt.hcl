include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_env("TERRAGRUNT_TERRAFORM_DIR")}/modules/domain/functional///"
}

dependency "base" {
  config_path = include.root.locals.dependency_paths.base

  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    resource_group__name = "rg-lpdapv000-env"

    services_subnet__id       = ""
    services_subnet__name     = "snet"
    services_subnet__nsg_name = ""
    services_subnet__nsg_id   = ""

    storage__storage_account_id   = "00000000-0000-0000-0000-000000000000"
    storage__storage_account_name = ""
    storage__primary_dfs_endpoint = ""

    interface_storage__storage_account_id = "00000000-0000-0000-0000-000000000000"

    databricks__private_subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-SUBSCR/subnets/snet-lpv000-env-databricks-private"
    databricks__public_subnet_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/AzureVnet/providers/Microsoft.Network/virtualNetworks/NNANPSpoke-LPDAP-SUBSCR/subnets/snet-lpv000-env-databricks-public"
    databricks__workspace_url     = ""
    databricks__workspace_id      = ""
    databricks__cluster_ids       = { "cluster-name" : "" }
    databricks__pat = {
      token_value = ""
    }
    databricks__managed_identity_principal_id = ""
    databricks__access_connector_principal_id = ""

    key_vault_sources__id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-lpdapv000-env/providers/Microsoft.KeyVault/vaults/kv-lpdapv000-env-xxxx"

    log_analytics_workspace__workspace_id            = ""
    log_analytics_workspace__primary_shared_key      = ""
    log_analytics_workspace__data_collection_rule_id = ""
    log_analytics_workspace__id                      = ""
  }
}

generate "provider_azapi" {
  path      = "provider-azapi.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azapi" {
  client_id = "${include.root.locals.env_variables.client_id}"
  subscription_id = "${include.root.locals.env_variables.subscription_id}"
  tenant_id = "${include.root.locals.env_variables.tenant_id}"
  client_secret = var.azure_client_secret
}
EOF
}

generate "provider_databricks" {
  path      = "provider-databricks.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  host = "${dependency.base.outputs.databricks__workspace_url}"

  azure_client_id = "${include.root.locals.env_variables.client_id}"
  azure_tenant_id = "${include.root.locals.env_variables.tenant_id}"
  azure_client_secret = var.azure_client_secret
}
EOF
}

locals {
  # User-Specific Cluster Names
  # Variable defined here for readability purposes
  legacy_user_specific_cluster_names = flatten([
    [
      for name, object_id in include.root.locals.domain_variables.object_ids.data_engineers : "legacy_cluster_${name}"
    ],
  ])

  user_specific_cluster_names = flatten([
    [
      for name, object_id in include.root.locals.domain_variables.object_ids.data_engineers : "cluster_${name}"
    ],
  ])

  ### ADF + Databricks Role Assignments
  roles_devops_engineers_adf_databricks = {
    for name, object_id in include.root.locals.domain_variables.object_ids.devops_engineers :
    object_id => ["Contributor"]
  }
  role_iam_enterprise_app_databricks = {
    "${include.root.locals.env_variables.iam_enterprise_object_id}" = ["Contributor"]
  }
  adf_roles        = local.roles_devops_engineers_adf_databricks
  databricks_roles = merge(local.adf_roles, local.role_iam_enterprise_app_databricks)

  ### Key Vault Infra Role Assignments
  roles_devops_engineers_kv_infra = {
    for name, object_id in include.root.locals.domain_variables.object_ids.devops_engineers :
    object_id => ["Key Vault Secrets User"]
  }
  roles_subscription_kv_infra = {
    for name, object_id in include.root.locals.env_variables.subscription_object_ids :
    object_id => ["Key Vault Secrets Officer"]
  }
  roles_kv_infra = merge(local.roles_devops_engineers_kv_infra, local.roles_subscription_kv_infra)

  ### Key Vault Sources Role Assignments
  roles_devops_engineers_kv_sources = {
    for name, object_id in include.root.locals.domain_variables.object_ids.devops_engineers :
    object_id => ["Key Vault Secrets Officer"]
  }
  roles_subscription_kv_sources = {
    for name, object_id in include.root.locals.env_variables.subscription_object_ids :
    object_id => ["Key Vault Secrets Officer"]
  }
  role_databricks_app_kv_sources = {
    "${include.root.locals.domain_variables.object_ids.azure_databricks_app}" = ["Key Vault Secrets User"]
  }
  roles_kv_sources = merge(local.roles_devops_engineers_kv_sources, local.roles_subscription_kv_sources, local.role_databricks_app_kv_sources)

  ### Storage Role Assignments
  roles_devops_engineers_storage = {
    for name, object_id in include.root.locals.domain_variables.object_ids.devops_engineers :
    object_id => ["Storage Blob Data Contributor"]
  }
  roles_adb_enterprise_application_storage = {
    for name, object_id in include.root.locals.domain_variables.object_ids.adb_enterprise_app :
    object_id => ["Storage Blob Data Contributor"]
  }
  roles_subscription_storage = {
    for name, object_id in include.root.locals.env_variables.subscription_object_ids :
    object_id => ["Storage Blob Data Contributor", "Storage Table Data Contributor"]
  }
  roles_storage = merge(local.roles_devops_engineers_storage, local.roles_adb_enterprise_application_storage, local.roles_subscription_storage)

  # The Entra group name that should get access to Unity Catalog resources consists of a few different parts
  unity_catalog_group_name = try(include.root.locals.domain_variables.entra_group_names.use_catalog, "")

  # Set the Azure IR name here once so we can re-use it for both ADF instances
  azure_integration_runtime_name = (
    include.root.locals.infrastructure_configuration.deploy_azure_hosted_integration_runtime ?
    upper("AZURE-IR-${include.root.locals.domain_label}") : ""
  )

}

inputs = {
  resource_group_name              = dependency.base.outputs.resource_group__name
  tags                             = include.root.locals.env_variables.tags
  meta_key_vault_name              = "kv-lpdapv001-meta-envs"
  meta_resource_group              = "rg-lpdapv001-meta"
  artifactory_password_secret_name = "ARTIFACTORY-PASSWORD"

  key_vault_vars = {
    name                                   = "kv-${include.root.locals.environment_label}-infra"
    tenant_id                              = "${include.root.locals.env_variables.tenant_id}"
    key_vault_private_endpoint_ip          = "${include.root.locals.domain_variables.ip_addresses.key_vault_infra_private_endpoint}"
    network_control_allowed_azure_services = true
    enable_rbac_authorization              = true
    network_control_allowed_subnet_ids = [
      dependency.base.outputs.databricks__private_subnet_id,
      dependency.base.outputs.databricks__public_subnet_id,
    ]

    # This list was used : https://nn.service-now.com/nn_ec?id=sc_cat_item&sys_id=e1738ba51bafd410797aea0e6e4bcbfb&sysparm_category=11b1adbedbce90106adb54904b961910
    network_control_allowed_ip_rules = [
      "8.25.203.0/24",
      "27.251.211.238/32",
      "64.74.126.64/26",
      "70.39.159.0/24",
      "72.52.96.0/26",
      "89.167.131.0/24",
      "104.129.192.0/20",
      "136.226.0.0/16",
      "137.83.128.0/18",
      "147.161.128.0/17",
      "165.225.0.0/17",
      "165.225.192.0/18",
      "185.46.212.0/22",
      "199.168.148.0/22",
      "213.152.228.0/24",
      "216.218.133.192/26",
      "216.52.207.64/26",
      "156.114.2.28/32"
    ]
    private_endpoint_subnet_id = dependency.base.outputs.services_subnet__id
  }

  data_factory_vars = [
    {
      # Data Factory 
      name                       = "adf-${include.root.locals.environment_label}"
      private_endpoint_subnet_id = dependency.base.outputs.services_subnet__id
      private_endpoint_ip        = "${include.root.locals.domain_variables.ip_addresses.data_factory_private_endpoint}"

      # Key Vault SHIR
      key_vault_name                               = "kv-${include.root.locals.environment_label}-shir"
      key_vault_tenant_id                          = "${include.root.locals.env_variables.tenant_id}"
      key_vault_private_endpoint_subnet_id         = dependency.base.outputs.services_subnet__id
      key_vault_enable_disk_encryption             = true
      key_vault_enable_rbac_authorization          = true
      key_vault_network_control_allowed_subnet_ids = []
      key_vault_create_private_endpoint            = false

      # Virtual Machine + SHIR
      shir_name = "IR-${upper(include.root.locals.environment_label)}"

      # Azure Hosted Integration Runtime
      storage_account_id             = dependency.base.outputs.storage__storage_account_id
      managed_private_endpoint_name  = "mpe-${dependency.base.outputs.storage__storage_account_name}"
      azure_integration_runtime_name = local.azure_integration_runtime_name
    },
    {
      name                       = "adf-${include.root.locals.environment_label}-02"
      private_endpoint_subnet_id = dependency.base.outputs.services_subnet__id
      private_endpoint_ip        = "${include.root.locals.domain_variables.ip_addresses.data_factory_02_private_endpoint}"
      git_sync_configuration = can(include.root.locals.domain_variables.data_factory_git_config) ? {
        account_name       = include.root.locals.domain_variables.data_factory_git_config.account_name
        branch_name        = include.root.locals.domain_variables.data_factory_git_config.branch_name
        project_name       = include.root.locals.domain_variables.data_factory_git_config.project_name
        repository_name    = include.root.locals.domain_variables.data_factory_git_config.repository_name
        root_folder        = include.root.locals.domain_variables.data_factory_git_config.root_folder
        tenant_id          = include.root.locals.env_variables.tenant_id
        publishing_enabled = false
      } : null

      # Key Vault SHIR
      key_vault_name                               = "kv-${include.root.locals.environment_label}-shir-02"
      key_vault_tenant_id                          = "${include.root.locals.env_variables.tenant_id}"
      key_vault_private_endpoint_subnet_id         = dependency.base.outputs.services_subnet__id
      key_vault_enable_disk_encryption             = true
      key_vault_enable_rbac_authorization          = true
      key_vault_network_control_allowed_subnet_ids = []
      key_vault_create_private_endpoint            = false

      # Virtual Machine + SHIR
      shir_name = upper("IR-${include.root.locals.domain_label}")

      # Azure Hosted Integration Runtime
      storage_account_id             = dependency.base.outputs.storage__storage_account_id
      azure_integration_runtime_name = local.azure_integration_runtime_name
    }
  ]

  virtual_machine_vars = [
    {
      virtual_machine_name_prefix            = "vmshir${include.root.locals.data_domain_short}${include.root.locals.version}${include.root.locals.environment}"
      virtual_machine_size                   = "${include.root.locals.domain_variables.virtual_machine_size}"
      virtual_machine_subnet_id              = dependency.base.outputs.services_subnet__id
      virtual_machine_private_ip_addresses   = concat(["${include.root.locals.domain_variables.ip_addresses.virtual_machine_1}"], try(["${include.root.locals.domain_variables.ip_addresses.virtual_machine_2}"], []))
      virtual_machine_accelerated_networking = true

      # Added Azure Team VM App CIS Hardening by specifying the hard resource id.
      virtual_machine_application_ids = concat(["/subscriptions/bb8694e0-ab4b-4641-bd51-9e61cc5cfa9a/resourceGroups/azurecentraliaas-we/providers/Microsoft.Compute/galleries/nn_general_iaas_gallery/applications/windows-cis-hardening/versions/latest"], flatten([
        [
          for name, version in include.root.locals.env_variables.vmapps.apps : "/subscriptions/${include.root.locals.env_variables.vmapps.gallery_subscription_id}/resourceGroups/${include.root.locals.env_variables.vmapps.gallery_rsg}/providers/Microsoft.Compute/galleries/${include.root.locals.env_variables.vmapps.gallery_name}/applications/${name}/versions/latest"
        ]
      ]))

      # Virtual Machine Extensions + Applications
      monitoring_agent_config = {
        log_analytics_workspace_workspace_id = dependency.base.outputs.log_analytics_workspace__workspace_id
        log_analytics_workspace_auth_key     = dependency.base.outputs.log_analytics_workspace__primary_shared_key
      }
      law_data_collection_rule_id = dependency.base.outputs.log_analytics_workspace__data_collection_rule_id
      vm_patch = {
        schedule_name = "maintenance-cfg-vm-patching-${include.root.locals.environment_label_short}"
        start_time    = include.root.locals.domain_variables.patch_schedule_start_time
        start_date    = include.root.locals.domain_variables.patch_schedule_start_date
        recur_every   = include.root.locals.domain_variables.patch_schedule_recur_every
        duration      = include.root.locals.domain_variables.patch_schedule_end_time
      }
    },
    {
      virtual_machine_name_prefix            = "vmshir${include.root.locals.data_domain_short}${include.root.locals.version}${include.root.locals.environment}"
      virtual_machine_size                   = "${include.root.locals.domain_variables.virtual_machine_size}"
      virtual_machine_subnet_id              = dependency.base.outputs.services_subnet__id
      virtual_machine_private_ip_addresses   = concat(["${include.root.locals.domain_variables.ip_addresses.virtual_machine_3}"], try(["${include.root.locals.domain_variables.ip_addresses.virtual_machine_4}"], []))
      virtual_machine_accelerated_networking = true

      # Added Azure Team VM App CIS Hardening by specifying the hard resource id.
      virtual_machine_application_ids = concat(["/subscriptions/bb8694e0-ab4b-4641-bd51-9e61cc5cfa9a/resourceGroups/azurecentraliaas-we/providers/Microsoft.Compute/galleries/nn_general_iaas_gallery/applications/windows-cis-hardening/versions/latest"], flatten([
        [
          for name, version in include.root.locals.env_variables.vmapps.apps : "/subscriptions/${include.root.locals.env_variables.vmapps.gallery_subscription_id}/resourceGroups/${include.root.locals.env_variables.vmapps.gallery_rsg}/providers/Microsoft.Compute/galleries/${include.root.locals.env_variables.vmapps.gallery_name}/applications/${name}/versions/latest"
        ]
      ]))

      # Virtual Machine Extensions + Applications
      monitoring_agent_config = {
        log_analytics_workspace_workspace_id = dependency.base.outputs.log_analytics_workspace__workspace_id
        log_analytics_workspace_auth_key     = dependency.base.outputs.log_analytics_workspace__primary_shared_key
      }
      law_data_collection_rule_id = dependency.base.outputs.log_analytics_workspace__data_collection_rule_id
      vm_patch = {
        schedule_name = "mnt-cfg-vm-patching-02-${include.root.locals.environment_label_short}"
        start_time    = include.root.locals.domain_variables.patch_schedule_start_time
        start_date    = include.root.locals.domain_variables.patch_schedule_start_date
        recur_every   = include.root.locals.domain_variables.patch_schedule_recur_every
        duration      = include.root.locals.domain_variables.patch_schedule_end_time
      }
    }
  ]

  adf_infra_components_vars = (include.root.locals.infrastructure_configuration.instance_type == "domain" ?
    {
      databricks_workspace_id  = dependency.base.outputs.databricks__workspace_id
      databricks_workspace_url = dependency.base.outputs.databricks__workspace_url
      key_vault_id             = dependency.base.outputs.key_vault_sources__id
      notebook_path            = "/execute_sql_query.py"
      subscription_id          = include.root.locals.env_variables.subscription_id

      # Storage Connection
      storage_account_primary_dfs_endpoint = dependency.base.outputs.storage__primary_dfs_endpoint

      dataset_config = [
        {
          dataset_name      = "raw_parquet"
          container_name    = "raw"
          file_type         = "Parquet"
          compression_codec = "snappy"
        },
        {
          dataset_name      = "raw_json"
          container_name    = "raw"
          file_type         = "Json"
          compression_codec = "None"
          level             = "Fastest"
        }
      ]
    } : null
  )

  databricks_functional_vars = {
    # Workspace configuration inputs
    workspace_config_nn_pypi_index_url          = "https://${get_env("ARTIFACTORY_USER")}:${get_env("ARTIFACTORY_PASSWORD")}@artifactory.insim.biz/artifactory/api/pypi/nn-pypi/simple"
    workspace_config_nn_customer_pypi_index_url = "https://${get_env("ARTIFACTORY_USER")}:${get_env("ARTIFACTORY_PASSWORD")}@artifactory.insim.biz/artifactory/api/pypi/nndap-pypi/simple"
    workspace_config_kafka_secret_name          = contains(["prd"], include.root.locals.env_variables.env_name) ? "ibm-kafka-acc-prd" : "ibm-kafka-dev-tst"

    # Databricks Asset Bundles
    workspace_url = "https://${dependency.base.outputs.databricks__workspace_url}"
    env_domain    = "${include.root.locals.env_variables.env_name}-${include.root.locals.domain_variables.abbreviation}"

    # Notebook Mounting Secrets
    notebook_mounting_secret_scope = "terraform"
    notebook_mounting_secrets = {
      "adls-client-id"  = include.root.locals.env_variables.client_id
      "adls-client-key" = include.root.locals.env_secrets.client_secret
      "adls-tenant-id"  = include.root.locals.env_variables.tenant_id
      "adls-st-name"    = dependency.base.outputs.storage__storage_account_name
    }

    # Variables for Legacy Clusters

    legacy_cluster_names               = include.root.locals.infrastructure_configuration.legacy_clusters_enabled ? ["cluster_load"] : []
    legacy_user_specific_cluster_names = include.root.locals.infrastructure_configuration.legacy_clusters_enabled && include.root.locals.infrastructure_configuration.env_type == "dev" ? local.legacy_user_specific_cluster_names : []

    # Variables for Primary Cluster(s)
    cluster_names         = ["cluster_main"]
    cluster_config        = include.root.locals.infrastructure_configuration.databricks_main_clusters
    cluster_pypi_packages = include.root.locals.infrastructure_configuration.databricks_pypi_packages

    # UC enabled
    cluster_uc_enabled = include.root.locals.infrastructure_configuration.uc_enabled

    # Legacy Cluster enabled
    legacy_clusters_enabled = include.root.locals.infrastructure_configuration.legacy_clusters_enabled

    # Variables for user-specific Cluster(s)
    # Only create user-specific clusters for domain teams, not for mall
    user_specific_cluster_names  = (include.root.locals.infrastructure_configuration.env_type == "dev" && include.root.locals.infrastructure_configuration.instance_type != "mall") ? local.user_specific_cluster_names : []
    user_specific_cluster_config = include.root.locals.infrastructure_configuration.databricks_user_specific_clusters

    cluster_unity_catalog_volume_storage_account_name   = replace("st${include.root.locals.environment_label}", "-", "")
    cluster_unity_catalog_volume_storage_container_name = include.root.locals.cluster_unity_catalog_storage_container_name
    cluster_unity_catalog_volume_name                   = include.root.locals.cluster_unity_catalog_volume_name

    # Variables for unity catalog schema / volume Entra group name
    env    = include.root.locals.env_variables.env_name
    domain = include.root.locals.domain_variables.abbreviation
    # TODO switch order of ternary statements here
    unity_catalog_group_name = local.unity_catalog_group_name
    unity_catalog_sp_name    = include.root.locals.env_variables.client_id

    # Service Principals
    service_principal_configuration_iam = {
      name           = "LPDAP-IAM-EA"
      application_id = include.root.locals.env_variables.iam_enterprise_app_id
    }
  }

  # Diagnostic Settings
  adf_diagnostics_vars = {
    log_analytics_workspace_id     = dependency.base.outputs.log_analytics_workspace__id
    log_analytics_destination_type = "Dedicated"

    enabled_logs = toset([
      "ActivityRuns",
      "PipelineRuns",
      "SSISIntegrationRuntimeLogs",
      "SSISPackageEventMessageContext",
      "SSISPackageEventMessages",
      "SSISPackageExecutableStatistics",
      "SSISPackageExecutionComponentPhases",
      "SSISPackageExecutionDataStatistics",
      "SandboxActivityRuns",
      "SandboxPipelineRuns",
      "TriggerRuns",
      "AirflowTaskLogs",
      "AirflowWorkerLogs",
      "AirflowDagProcessingLogs",
      "AirflowSchedulerLogs",
      "AirflowWebLogs"
    ])

    metrics = [
      {
        category = "AllMetrics"
        enabled  = true
      }
    ]
  }

  databricks_diagnostics_vars = {
    target_resource_id         = dependency.base.outputs.databricks__workspace_id
    log_analytics_workspace_id = dependency.base.outputs.log_analytics_workspace__id
    enabled_logs = toset(["mlflowAcledArtifact", "instancePools", "jobs", "workspace", "clusters", "dbfs", "sqlanalytics", "mlflowExperiment", "featureStore", "notebook", "iamRole",
      "secrets", "sqlPermissions", "ssh", "globalInitScripts", "accounts", "genie", "RemoteHistoryService", "databrickssql", "deltaPipelines", "modelRegistry", "repos",
    "unityCatalog", "gitCredentials", "webTerminal", "serverlessRealTimeInference", "clusterLibraries", "partnerHub", "clamAVScan", "capsule8Dataplane"])
  }

  disk_encryption_diagnostics_vars = {
    log_analytics_workspace_id     = dependency.base.outputs.log_analytics_workspace__id
    log_analytics_destination_type = "Dedicated"
    enabled_logs                   = toset(["AuditEvent", "AzurePolicyEvaluationDetails"])
    metrics = [
      {
        category = "AllMetrics"
        enabled  = true
      }
    ]
  }

  kv_infra_diagnostics_vars = {
    log_analytics_workspace_id = dependency.base.outputs.log_analytics_workspace__id
    enabled_logslogs           = toset(["AuditEvent"])
    metrics = [
      {
        category = "AllMetrics"
        enabled  = true
      },
    ]
  }

  kv_sources_diagnostics_vars = {
    target_resource_id         = dependency.base.outputs.key_vault_sources__id
    log_analytics_workspace_id = dependency.base.outputs.log_analytics_workspace__id
    enabled_logs               = toset(["AuditEvent"])
    metrics = [
      {
        category = "AllMetrics"
        enabled  = true
      },
    ]
  }

  storage_diagnostics_vars = {
    storage_account_id         = dependency.base.outputs.storage__storage_account_id
    log_analytics_workspace_id = dependency.base.outputs.log_analytics_workspace__id
    enabled_logs               = toset(["StorageDelete", "StorageRead", "StorageWrite"])
    metrics = [
      {
        category = "Transaction"
        enabled  = true
      },
      {
        category = "Capacity"
        enabled  = false
      }
    ]
  }

  # Role Assignments
  adf_role_assignments_vars = {
    user_principal_roles = {}
    principal_id_roles = merge(
      local.adf_roles,
      {
        "${dependency.base.outputs.databricks__managed_identity_principal_id}" = ["Data Factory Contributor"]
      }
    )
  }

  databricks_role_assignments_vars = {
    resource_ids         = [dependency.base.outputs.databricks__workspace_id]
    user_principal_roles = {}
    principal_id_roles   = local.databricks_roles,
  }

  kv_infra_role_assignments_vars = {
    user_principal_roles = {}
    principal_id_roles   = local.roles_kv_infra
  }

  kv_sources_role_assignments_vars = {
    resource_ids         = [dependency.base.outputs.key_vault_sources__id]
    user_principal_roles = {}
    principal_id_roles   = local.roles_kv_sources
  }

  storage_role_assignments_vars = {
    resource_ids         = [dependency.base.outputs.storage__storage_account_id]
    user_principal_roles = {}
    principal_id_roles = merge(
      local.roles_storage,
      { "${dependency.base.outputs.databricks__access_connector_principal_id}" = ["Storage Account Contributor", "Storage Blob Data Contributor", "Storage Queue Data Contributor", "EventGrid EventSubscription Contributor"] }
    )
  }

  interface_storage_role_assignments_vars = (include.root.locals.infrastructure_configuration.deploy_interface_storage_account ? {
    resource_ids = [dependency.base.outputs.interface_storage__storage_account_id]
    principal_id_roles = merge(
      local.roles_storage,
      { "${dependency.base.outputs.databricks__access_connector_principal_id}" = ["Storage Account Contributor", "Storage Blob Data Contributor", "Storage Queue Data Contributor", "EventGrid EventSubscription Contributor"] }
    )
  } : null)

  # Version.txt file on meta bucket for version identification
  version_vars = {
    storage_account_name   = get_env("TFSTATE_STORAGE_ACCOUNT_NAME")
    storage_container_name = include.root.locals.container_name
    blob_folder            = "${include.root.locals.data_domain}"
    infra_modules_version  = include.root.locals.infra_modules_version
  }
}

retryable_errors = [
  "(?s).*each.value*",
  "(?s).*unexpected state Pending.*"
]
