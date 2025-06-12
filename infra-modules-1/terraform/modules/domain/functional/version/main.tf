resource "azurerm_storage_blob" "version_blob" {

  provider = azurerm.meta

  name                   = "${var.blob_folder}/version-${var.infra_modules_version}.txt"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source_content         = var.infra_modules_version
  content_type           = "text/plain"

}
