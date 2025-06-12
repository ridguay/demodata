terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.51.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.0"
    }
  }

  required_version = "~> 1.3.0"
}
