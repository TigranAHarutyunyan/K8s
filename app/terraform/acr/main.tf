resource "azurerm_container_registry" "acr" {
  location            = var.location
  name                = var.acr-name
  resource_group_name = var.rg-name
  sku                 = "Basic"
}

data "azurerm_client_config" "current" {}
resource "azurerm_role_assignment" "acr-push" {
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = data.azurerm_client_config.current.id
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  skip_service_principal_aad_check = false
}
resource "azurerm_container_registry_task" "acrt" {
  container_registry_id = azurerm_container_registry.acr.id
  name                  = "build-flask-app"
  platform {
    os           = "Linux"
    architecture = "amd64"
  }
  docker_step {
    dockerfile_path      = "app/Dockerfile"
    context_path         = var.context_path
    context_access_token = var.context_access_token
    image_names          = ["flask-redis-app:v1"]
    push_enabled         = true
  }
}
resource "azurerm_container_registry_task_schedule_run_now" "app_image" {
  container_registry_task_id = azurerm_container_registry_task.acrt.id
}

