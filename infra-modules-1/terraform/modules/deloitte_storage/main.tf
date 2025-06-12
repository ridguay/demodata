### Resource Group ###
module "resource_group" {
  source = "./resource_group"

  name     = var.resource_group_vars.name
  location = var.location
  tags     = var.resource_group_vars.tags
}

### Services Subnet ###
module "services_subnet" {
  source = "./services_subnet"

  subnet_name           = var.services_subnet_vars.subnet_name
  subnet_address_prefix = var.services_subnet_vars.subnet_address_prefix
  virtual_network_data  = var.services_subnet_vars.virtual_network_data
}

module "storage" {
  source = "./storage"

  resource_group_name      = module.resource_group.name
  storage_account_location = var.location

  storage_account_name             = var.storage_vars.name
  storage_account_account_tier     = var.storage_vars.account_tier
  storage_account_replication_type = var.storage_vars.replication_type
  delete_policy                    = var.storage_vars.delete_policy
  customer_managed_key             = var.storage_vars.customer_managed_key
  storage_management_policy        = var.storage_vars.storage_management_policy

  tags                       = var.storage_vars.tags
  storage_account_extra_tags = var.storage_vars.storage_account_extra_tags


  network_control_allowed_ip_rules = var.storage_vars.network_control_allowed_ip_rules
  configure_default_network_rules  = var.storage_vars.configure_default_network_rules
  private_link_access_tenant_id    = var.tenant_id
  add_private_link_access          = var.storage_vars.add_private_link_access
  network_rules_bypasses           = var.storage_vars.network_rules_bypasses
  private_endpoint_subnet_id       = module.services_subnet.subnet_id
  dfs_private_endpoint_ip          = var.storage_vars.dfs_private_endpoint_ip
  blob_private_endpoint_ip         = var.storage_vars.blob_private_endpoint_ip
  container_names                  = var.storage_vars.container_names
  shared_access_key_enabled        = var.storage_vars.shared_access_key_enabled
  default_to_oauth_authentication  = var.storage_vars.default_to_oauth_authentication

  depends_on = [module.resource_group, module.services_subnet]
}

module "resource_group_role_assignments" {
  source = "./role_assignments"

  resource_ids         = [module.resource_group.id]
  user_principal_roles = var.resource_group_role_assignment_vars.user_principal_roles
  principal_id_roles   = var.resource_group_role_assignment_vars.principal_id_roles
}

module "storage_role_assignments" {
  source = "./role_assignments"

  resource_ids         = [module.storage.storage_id]
  user_principal_roles = var.storage_role_assignment_vars.user_principal_roles
  principal_id_roles   = var.storage_role_assignment_vars.principal_id_roles
}
