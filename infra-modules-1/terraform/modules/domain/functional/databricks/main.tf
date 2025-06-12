### WORKSPACE CONFIG ###
resource "databricks_workspace_conf" "this" {
  custom_config = {
    "storeInteractiveNotebookResultsInCustomerAccount" : "true"
  }
}

resource "databricks_dbfs_file" "artifactory_certificates" {
  for_each       = local.certificates
  content_base64 = filebase64(each.value)
  path           = "/init-scripts/certificates/${each.key}"
}

resource "databricks_global_init_script" "artifactory_init_script" {
  name     = "artifactory_init_script"
  position = 0
  enabled  = true

  content_base64 = base64encode(templatefile("${abspath(path.module)}/artifactory-init-scripts-legacy/artifactory_init.sh.tpl", {
    index_url       = var.workspace_config__nn_pypi_index_url
    extra_index_url = var.workspace_config__nn_customer_pypi_index_url
  }))
}

resource "databricks_cluster_policy" "dlt_cluster_policy" {
  name = "DLT Kafka Policy"

  definition = jsonencode(
    {
      "spark_env_vars.KAFKA_CERT" : {
        "type" : "fixed",
        "value" : "{{secrets/ibm_kafka_scope/kafka_certificate}}"
      }
  })
}

resource "databricks_token" "pat" {
  comment          = "Terraform generated. Databricks Asset Bundles deployment."
  lifetime_seconds = 31536000 # 365 days
}

### DAB Secrets ###
resource "azurerm_key_vault_secret" "secret_meta" {
  count = length(local.secret_names)

  provider     = azurerm.meta
  name         = local.secret_names[count.index]
  value        = local.dab_secrets[local.secret_names[count.index]]
  key_vault_id = var.meta_key_vault_id

  depends_on = [databricks_token.pat]
}

# Create a secret scope specifically to retrieve a kafka certificate from the meta key vault and store it as a secret in Databricks
# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/secret_scope
resource "databricks_secret_scope" "ibm_kafka_scope" {
  name = "ibm_kafka_scope"
}

# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/secret
resource "databricks_secret" "kafka_certificate" {
  key          = "kafka_certificate"
  string_value = var.workspace_config__kafka_secret #data.azurerm_key_vault_secret.kafka_certificate.value
  scope        = databricks_secret_scope.ibm_kafka_scope.id
}

### NOTEBOOK MOUNTING SECRETS ###
# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/secret_scope
resource "databricks_secret_scope" "scope" {
  name = var.notebook_mounting_secret_scope
}

# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/secret
resource "databricks_secret" "secrets" {
  for_each     = var.notebook_mounting_secrets
  key          = each.key
  string_value = each.value
  scope        = databricks_secret_scope.scope.id
}

### Service Principal IAM ###
data "databricks_group" "admins" {
  display_name = "admins"
}

resource "databricks_service_principal" "iam" {
  application_id       = var.service_principal_configuration_iam.application_id
  display_name         = var.service_principal_configuration_iam.name
  allow_cluster_create = false
  force                = true
}

resource "databricks_group_member" "admins" {
  group_id  = data.databricks_group.admins.id
  member_id = databricks_service_principal.iam.id
  depends_on = [data.databricks_group.admins,
  databricks_service_principal.iam]
}
