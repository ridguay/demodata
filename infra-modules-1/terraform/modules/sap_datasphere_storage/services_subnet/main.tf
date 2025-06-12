# NOTE: Using a single network security group, because "If you use the Workspace ARM template or a custom ARM template,
#       it is up to you to ensure that your two subnets for the workspace use the same network security group and are
#       properly delegated." Source: https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-inject
resource "azurerm_network_security_group" "firewall" {
  resource_group_name = data.azurerm_virtual_network.virtual_network.resource_group_name
  name                = "nsg-${var.subnet_name}"
  location            = var.location
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      security_rule # Security rules are managed using `azurerm_network_security_rule` resources
    ]
  }
}

# Use separate network_security_rule resources to prevent conflicts with policy-deployed rules such as
# the default deny rule
# Integration Runtime Remote Access https://docs.microsoft.com/en-us/azure/data-factory/create-self-hosted-integration-runtime#enable-remote-access-from-an-intranet
resource "azurerm_network_security_rule" "AllowAccessFromControlPlane" {
  resource_group_name         = data.azurerm_virtual_network.virtual_network.resource_group_name
  network_security_group_name = azurerm_network_security_group.firewall.name
  name                        = "AllowAccessFromControlPlane"
  priority                    = 2000

  access                     = "Allow"
  direction                  = "Inbound"
  protocol                   = "Tcp"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_port_ranges    = ["443"]
  destination_address_prefix = var.subnet_address_prefix

  depends_on = [
    azurerm_network_security_group.firewall
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_virtual_network.virtual_network.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.subnet_address_prefix]
  service_endpoints = [
    "Microsoft.AzureActiveDirectory", "Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql"
  ]
  private_endpoint_network_policies = "Enabled"
}

# Link the subnet to the network security group
# This is done through the azapi_update_resource because of a policy that adds the
# YouShallNotPass security group to subnets.
# Inspiration: https://github.com/hashicorp/terraform-provider-azurerm/issues/9022
resource "azapi_update_resource" "firewall_association" {
  type        = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
  resource_id = azurerm_subnet.subnet.id

  body = jsonencode({
    properties = {
      networkSecurityGroup = {
        id = azurerm_network_security_group.firewall.id
      }

    }
  })

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_network_security_group.firewall
  ]
}
