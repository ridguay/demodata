resource "random_password" "admin_password" {
  length           = 16
  special          = true
  min_lower        = 4
  min_numeric      = 4
  min_special      = 4
  min_upper        = 4
  override_special = "!?#@&$*"
}

resource "azurerm_windows_virtual_machine" "vm" {
  resource_group_name = var.resource_group_name
  location            = var.virtual_machine_location
  tags                = var.tags

  name               = var.virtual_machine_name
  size               = var.virtual_machine_size
  license_type       = "Windows_Server"
  admin_username     = "lpdapuser"
  admin_password     = random_password.admin_password.result
  provision_vm_agent = "true"
  timezone           = var.virtual_machine_timezone
  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]
  enable_automatic_updates = false
  patch_mode               = "AutomaticByPlatform"
  patch_assessment_mode    = "AutomaticByPlatform"

  os_disk {
    name                 = "dsk-${var.virtual_machine_name}"
    caching              = "ReadWrite"
    storage_account_type = var.virtual_machine_os_disk_storage_account_type
    disk_size_gb         = var.virtual_machine_os_disk_size_gb
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "gallery_application" {
    for_each = var.virtual_machine_application_ids
    content {
      version_id                = gallery_application.value
      automatic_upgrade_enabled = true
    }
  }

  lifecycle {
    ignore_changes = [custom_data]
  }
}

resource "azurerm_network_security_group" "vm" {
  resource_group_name = var.resource_group_name
  name                = "nsg-${var.virtual_machine_name}"
  location            = var.virtual_machine_location
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      security_rule # Security rules are managed using `azurerm_network_security_rule` resources
    ]
  }
}

resource "azurerm_network_security_rule" "allow_rdp_access" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm.name
  name                        = "AllowBastionRDP3389Inbound"
  priority                    = 2000

  access                     = "Allow"
  direction                  = "Inbound"
  protocol                   = "Tcp"
  source_port_range          = "*"
  source_address_prefixes    = ["10.202.14.0/26", "10.205.21.224/28"] # 10.205.21.224/28 Citrix 10.202.14.0/26 Bastion
  destination_port_ranges    = ["3389"]
  destination_address_prefix = "*"

  depends_on = [
    azurerm_network_security_group.vm
  ]
}

resource "azurerm_network_interface" "vm" {
  resource_group_name            = var.resource_group_name
  location                       = var.virtual_machine_location
  name                           = "nic-${var.virtual_machine_name}"
  accelerated_networking_enabled = var.virtual_machine_accelerated_networking
  tags                           = var.tags

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.virtual_machine_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.virtual_machine_private_ip_address
  }
}

resource "azurerm_network_interface_security_group_association" "vm" {
  network_interface_id      = azurerm_network_interface.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id

  depends_on = [
    azurerm_network_interface.vm,
    azurerm_network_security_rule.allow_rdp_access
  ]
}
