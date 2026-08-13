resource "azurerm_kubernetes_cluster" "aks" {
  location            = var.location
  name                = var.aks-name
  resource_group_name = var.rg-name
  dns_prefix          = var.aks-name
  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2s_v7"
    type       = "VirtualMachineScaleSets"
  }
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_kubernetes_cluster_node_pool" "frontend" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = "frontendpool"
  vm_size               = "Standard_D2s_v7"
  node_count            = 1
  mode                  = "User"
  node_labels = {
    workload = "frontendpool"
  }
}
resource "azurerm_kubernetes_cluster_node_pool" "backend" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = "backendpool"
  vm_size               = "Standard_D2s_v7"
  node_count            = 1
  mode                  = "User"
  node_labels = {
    workload = "backendpool"
  }
}
