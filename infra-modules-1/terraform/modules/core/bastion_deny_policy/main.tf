resource "azurerm_policy_definition" "deny-bastion-policy" {
  name         = "DenyBastionPolicy"
  display_name = "Bastion deployments should be denied"
  mode         = "Indexed"
  policy_type  = "Custom"

  # Addition policy definition code...  
  policy_rule = file("${path.module}/Deny_Bastion_Policy.json")
}

resource "azurerm_subscription_policy_assignment" "denybastion" {
  name                 = "DenyBastion"
  subscription_id      = local.subscription_id
  policy_definition_id = azurerm_policy_definition.deny-bastion-policy.id
}