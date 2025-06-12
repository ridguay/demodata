resource "azurerm_role_assignment" "role_assignment" {
  count = local.role_assignment_count

  scope                = local.role_assignments[count.index].resource_id
  principal_id         = local.role_assignments[count.index].principal_id
  role_definition_name = local.role_assignments[count.index].role
}
