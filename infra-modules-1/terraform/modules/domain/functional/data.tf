data "azurerm_key_vault" "meta_key_vault" {
  provider            = azurerm.meta
  name                = var.meta_key_vault_name
  resource_group_name = var.meta_resource_group
}

data "azurerm_key_vault_secret" "artifactory_password" {
  provider     = azurerm.meta
  name         = var.artifactory_password_secret_name
  key_vault_id = data.azurerm_key_vault.meta_key_vault.id
}

data "azurerm_key_vault_secret" "kafka_certificate" {
  provider     = azurerm.meta
  name         = var.databricks_functional_vars.workspace_config_kafka_secret_name
  key_vault_id = data.azurerm_key_vault.meta_key_vault.id
}
