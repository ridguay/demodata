terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
      configuration_aliases = [
        azurerm.meta
      ]
    }
  }

  required_version = "~> 1.3.0"
}
