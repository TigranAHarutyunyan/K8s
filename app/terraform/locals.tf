locals {
  rg-name  = format("rg-%s", var.name-pattern)
  aks-name = format("aks-%s", var.name-pattern)
  acr-name = format("acr%s", var.name-pattern)

}
