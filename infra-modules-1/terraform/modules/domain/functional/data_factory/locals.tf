locals {
  # Data Factory
  private_endpoint_name                    = "pe-${var.name}"
  private_endpoint_service_connection_name = "psc-${var.name}"

  # Key Vault SHIR
  key_vault_private_endpoint_name_prefix                    = "pe-${var.key_vault_name}"
  key_vault_private_endpoint_service_connection_name_prefix = "psc-${var.key_vault_name}"
}