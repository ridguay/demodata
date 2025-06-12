terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "1.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
    }
  }

  required_version = "~> 1.3.0"
}
