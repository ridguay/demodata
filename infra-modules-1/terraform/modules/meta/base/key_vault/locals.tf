locals {
  private_endpoint_name_prefix                    = "pe-${var.key_vault_name}"
  private_endpoint_service_connection_name_prefix = "psc-${var.key_vault_name}"
}
