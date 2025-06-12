data "archive_file" "archive" {
  type             = "zip"
  output_path      = var.output_path
  source_dir       = var.source_path
  output_file_mode = 0770
}

resource "azurerm_storage_blob" "archive" {
  name                   = var.file_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.container_name
  type                   = "Block"
  source                 = data.archive_file.archive.output_path
}

data "azurerm_storage_account_blob_container_sas" "archive" {
  connection_string = var.connection_string
  container_name    = azurerm_storage_blob.archive.storage_container_name
  https_only        = true
  start             = formatdate("YYYY-MM-DD", timestamp())
  expiry            = formatdate("YYYY-MM-DD", timeadd(timestamp(), "24h"))

  permissions {
    read   = true
    add    = true
    create = false
    write  = true
    delete = true
    list   = true
  }
}


resource "azurerm_gallery_application" "gallery" {
  name              = var.app_name
  gallery_id        = var.gallery_id
  location          = var.location
  supported_os_type = "Windows"
}

resource "azurerm_gallery_application_version" "appversion" {
  name                   = var.app_version
  gallery_application_id = azurerm_gallery_application.gallery.id
  location               = azurerm_gallery_application.gallery.location

  manage_action {
    install = var.app_install_cmd
    remove  = var.app_remove_cmd
  }

  source {
    media_link = azurerm_storage_blob.archive.id
  }

  target_region {
    name                   = azurerm_gallery_application.gallery.location
    regional_replica_count = 3
  }
}
