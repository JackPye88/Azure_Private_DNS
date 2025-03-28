terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version               = ">= 4.16.0"
    }
  }

}
provider "azurerm" {
  subscription_id = "ENTER_SUBSCRIPTION_ID"
    features {}

}

provider "azurerm" {
  alias   = "identity"
  subscription_id = "ENTER_SUBSCRIPTION_ID"
  features {}

}
