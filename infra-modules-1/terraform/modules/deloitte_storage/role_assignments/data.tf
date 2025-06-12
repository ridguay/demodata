# Get for each user principal the matching principal id through AAD lookup
# For some reason our terraform is not authorised to retrieve this data.
data "azuread_user" "aad_user" {
  for_each            = var.user_principal_roles
  user_principal_name = each.key
}