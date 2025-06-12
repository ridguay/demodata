locals {
  is_customer_managed_keys_provided               = var.customer_managed_key != null ? true : false
  smp_version_tier_to_cool_days                   = ceil(var.storage_management_policy.move_to_cool_after_days / 2)
  smp_snapshot_tier_to_cool_days                  = ceil(local.smp_version_tier_to_cool_days / 2)
  private_endpoint_name_prefix                    = "pe-${var.storage_account_name}"
  private_endpoint_service_connection_name_prefix = "psc-${var.storage_account_name}"
}