terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.51.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
      configuration_aliases = [
        azurerm,
        azurerm.meta
      ]
    }

  }

  required_version = "~> 1.3.0"
}
