locals {


  # Convert the input mapping from:
  # { user1 = ["role1", "role2"], user2 = ... }
  # into:
  # [
  #   { "principal_id" = "<user1-id>", "role" = "role1" },
  #   { "principal_id" = "<user1-id>", "role" = "role2" },
  #   { "principal_id" = "<user2-id>", "role" = ... },
  # ]
  user_principal_role_assignments = flatten([
    for user, roles in var.user_principal_roles : [
      for role in roles : {
        principal_id = data.azuread_user.aad_user[user].id
        role         = role
      }
    ]
  ])

  # Convert the input mapping from:
  # { id1 = ["role1", "role2"], id2 = ... }
  # into:
  # [
  #   { "principal_id" = "id1", "role" = "role1" },
  #   { "principal_id" = "id1", "role" = "role2" },
  #   { "principal_id" = "id2", "role" = ... },
  # ]
  principal_id_role_assignments = flatten([
    for principal_id, roles in var.principal_id_roles : [
      for role in roles : {
        principal_id = principal_id
        role         = role
      }
    ]
  ])

  # When calling the role assignments submodule, we sometimes have principal ids that can only be known at runtime (i.e., when running terraform plan)
  # This causes issues whenever we want to deploy from scratch. Therefore, we pass a separate argument "runtime_object_ids" and replace the placeholder
  # principal ids with the ids that are known at runtime. 
  principal_id_role_assignments_substituted = [
    for role in local.principal_id_role_assignments : {
      principal_id = try(var.runtime_object_ids[role.principal_id], role.principal_id)
      role         = role.role
    }
  ]

  # List of mappings containing the keys 'principal_id' and 'role'
  principal_id_roles = concat(local.user_principal_role_assignments, local.principal_id_role_assignments_substituted)

  # List of mappings containing the keys 'principal_id', 'role' and 'resource_id'
  # For the resource_id specified, the given principal_id should get the specified role
  role_assignments = flatten([
    for resource_id in var.resource_ids :
    [
      for role_assignment in local.principal_id_roles :
      {
        resource_id  = resource_id
        principal_id = role_assignment.principal_id
        role         = role_assignment.role
      }
    ]
  ])

  role_assignment_count = length(var.resource_ids) * (length(local.user_principal_role_assignments) + length(local.principal_id_role_assignments))
}
