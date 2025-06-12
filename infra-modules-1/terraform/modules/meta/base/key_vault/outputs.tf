output "key_vault_id" {
  description = "Id of Key Vault instance"
  value       = azurerm_key_vault.key_vault.id
}

output "vault_uri" {
  description = "Uri of the Key Vault instance"
  value       = azurerm_key_vault.key_vault.vault_uri
}
