variable "resource_ids" {
  description = "Ids of the resource to which to assign the roles to."
  type        = list(string)
}

variable "user_principal_roles" {
  description = "Roles to add based on user principal name\nExample: { 'user@insim.biz' = ['Data Factory Contributor'] }"
  type        = map(list(string)) # e.g. user@insim.biz = ["Data Factory Contributor"]
  default     = {}
}

variable "principal_id_roles" {
  description = "Roles to add based on principal id\nExample: { '00000000-0000-0000-0000-000000000000' = ['Data Factory Contributor'] }"
  type        = map(list(string)) # e.g. "4ea9b04f-00e7-4d2c-a6e4-ec854cc7fc30" = ["Data Factory Contributor"]
  default     = {}
}

# When calling the role assignments submodule, we sometimes have principal ids that can only be known at runtime (i.e., when running terraform plan)
# This causes issues whenever we want to deploy from scratch. Therefore, we pass a separate argument "runtime_object_ids" and replace the placeholder
# principal ids with the ids that are known at runtime (see locals.tf). 
variable "runtime_object_ids" {
  description = "Object ids from resources that can only be determined at runtime."
  type        = map(string)
  default     = {}
}
