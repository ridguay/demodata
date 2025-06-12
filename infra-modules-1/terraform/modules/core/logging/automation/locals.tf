locals {
  start_time = "${formatdate("YYYY-MM-DD", timeadd(timestamp(), "24h"))}T08:00:00Z"
}
