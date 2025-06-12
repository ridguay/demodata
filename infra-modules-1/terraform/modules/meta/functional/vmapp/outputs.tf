output "app_version_id" {
  description = "The Id of the VM Application Gallery instance"
  value       = azurerm_gallery_application_version.appversion.id
}
