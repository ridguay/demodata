data "azurerm_storage_account" "tfstate" {
  count = var.deploy_storage_account ? 0 : 1

  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}
