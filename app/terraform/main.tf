provider "azurerm" {
  features {

  }
}
provider "random" {
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = local.rg-name
}
module "aks" {
  source   = "./aks"
  rg-name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  aks-name = local.aks-name
}
module "acr" {
  source               = "./acr"
  rg-name              = azurerm_resource_group.rg.name
  context_path         = var.context_path
  context_access_token = var.context_access_token
  acr-name             = local.acr-name
  location             = var.location
}
