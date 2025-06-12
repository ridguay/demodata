### Data Factory ###
output "id" {
  description = "Id of the Data Factory instance"
  value       = azurerm_data_factory.data_factory.id
}

output "object_id" {
  description = "Object Id (identity) of the Data Factory instance"
  value       = azurerm_data_factory.data_factory.identity[0].principal_id
}

# Azure policies create a private DNS zone binding as soon as this resource is created.
# Depending on the speed of the policy execution, we will need to fetch the IP address 
# and FQDN from the custom DNS config _or_ the private DNS zone config.
# See also the following link for more info:
# https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation/#the-output-source-of-ip-and-fqdn-of-your-private-endpoint-can-change
output "private_endpoint_ip_address" {
  description = "Ip address of the private endpoint of Data Factory instance"
  value       = length(azurerm_private_endpoint.data_factory.custom_dns_configs) > 0 ? azurerm_private_endpoint.data_factory.custom_dns_configs[0].ip_addresses[0] : azurerm_private_endpoint.data_factory.private_dns_zone_configs[0].record_sets[0].ip_addresses[0]
}

# Azure policies create a private DNS zone binding as soon as this resource is created.
# Depending on the speed of the policy execution, we will need to fetch the IP address 
# and FQDN from the custom DNS config _or_ the private DNS zone config.
# See also the following link for more info:
# https://making.nn.nl/spaces/cloud/azure-cloud-platform/faq-and-how-to-guides/networking/private-endpoints/migration-to-policy-based-dns-record-creation/#the-output-source-of-ip-and-fqdn-of-your-private-endpoint-can-change
output "private_endpoint_fqdn" {
  description = "Fully Qualified Domain Name of the Data Factory instance"
  value       = length(azurerm_private_endpoint.data_factory.custom_dns_configs) > 0 ? azurerm_private_endpoint.data_factory.custom_dns_configs[0].fqdn : azurerm_private_endpoint.data_factory.private_dns_zone_configs[0].record_sets[0].fqdn
}

### Self-Hosted Integration Runtime ###
output "shir_authorization_key" {
  description = "Primary authorization key of the self-hosted integration runtime"
  value       = azurerm_data_factory_integration_runtime_self_hosted.adf_shir.primary_authorization_key
}

output "shir_name" {
  description = "Name of the Self-Hosted Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_self_hosted.adf_shir.name
}

### Key Vault SHIR ###
output "key_vault_id" {
  description = "Id of Key Vault instance"
  value       = azurerm_key_vault.key_vault.id
}

output "vault_uri" {
  description = "Uri of the Key Vault instance"
  value       = azurerm_key_vault.key_vault.vault_uri
}

### Azure hosted integration runtime ### 
output "managed_pe_name" {
  description = "Name of the Managed Private Endpoint"
  value       = try(azurerm_data_factory_managed_private_endpoint.managed_pe[0].name, "")
}

output "azure_ir_name" {
  description = "Name of the Managed Integration Runtime"
  value       = try(azurerm_data_factory_integration_runtime_azure.azure_ir[0].name, "")
}