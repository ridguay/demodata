moved {
  from = module.databricks_networking.azapi_update_resource.private_firewall_association
  to   = module.databricks.azapi_update_resource.private_firewall_association
}

moved {
  from = module.databricks_networking.azapi_update_resource.public_firewall_association
  to   = module.databricks.azapi_update_resource.public_firewall_association
}

moved {
  from = module.databricks_networking.azurerm_databricks_access_connector.dac
  to   = module.databricks.azurerm_databricks_access_connector.dac
}

moved {
  from = module.databricks_networking.azurerm_network_security_group.firewall
  to   = module.databricks.azurerm_network_security_group.firewall
}

moved {
  from = module.databricks_networking.azurerm_subnet.private_subnet
  to   = module.databricks.azurerm_subnet.private_subnet
}

moved {
  from = module.databricks_networking.azurerm_subnet.public_subnet
  to   = module.databricks.azurerm_subnet.public_subnet
}
