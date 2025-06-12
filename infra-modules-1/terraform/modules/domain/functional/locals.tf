locals {
  storage_diagnostics_target_resource_ids = var.storage_diagnostics_vars != null ? {
    blob  = "${var.storage_diagnostics_vars.storage_account_id}/blobServices/default"
    file  = "${var.storage_diagnostics_vars.storage_account_id}/fileServices/default"
    queue = "${var.storage_diagnostics_vars.storage_account_id}/queueServices/default"
    table = "${var.storage_diagnostics_vars.storage_account_id}/tableServices/default"
  } : {}

  kv_secrets = var.key_vault_vars != null ? {
    "${module.vm[0].virtual_machine_name}-admin-user"     = sensitive(module.vm[0].virtual_machine_admin_username)
    "${module.vm[0].virtual_machine_name}-admin-password" = sensitive(module.vm[0].virtual_machine_admin_password)
  } : {}
  kv_secrets_names = [for name, value in local.kv_secrets : name]

  runtime_object_ids = try({
    adf  = "${module.data_factory[0].object_id}",
    adf2 = "${module.data_factory[1].object_id}"
  }, {})
}
