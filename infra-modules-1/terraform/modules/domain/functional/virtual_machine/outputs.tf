output "virtual_machine_id" {
  description = "Id of the virtual machine"
  value       = azurerm_windows_virtual_machine.vm.id
}

output "virtual_machine_name" {
  description = "Name of the virtual machine"
  value       = azurerm_windows_virtual_machine.vm.name
}

output "virtual_machine_admin_username" {
  description = "Administrator username of the virtual machine"
  value       = azurerm_windows_virtual_machine.vm.admin_username
}

output "virtual_machine_admin_password" {
  description = "Administrator password of the virtual machine"
  value       = random_password.admin_password.result
  sensitive   = true
}

output "vm_secrets" {
  description = "Secrets for the vm"
  value = {
    "${azurerm_windows_virtual_machine.vm.name}-admin-user"     = "adminuser"
    "${azurerm_windows_virtual_machine.vm.name}-admin-password" = random_password.admin_password.result
  }
  # sensitive = true
}