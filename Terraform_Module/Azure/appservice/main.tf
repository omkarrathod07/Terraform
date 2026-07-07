resource "azurerm_resource_group" "practic-rg" {
  name = "${var.name}-rg"
  location = var.location
}
resource "azurerm_app_service_plan" "practic-app-service-plan" {
  name = "${var.name}-asp"
  location = var.location
  resource_group_name = azurerm_resource_group.practic-rg.name

  sku {
    tier = var.sku.tier
    size = var.sku.size
  }
}
resource "azurerm_app_service" "practic-app-service" {
  name = "${var.name}-app-service"
  location = var.location
  resource_group_name = azurerm_resource_group.practic-rg.name
  app_service_plan_id = azurerm_app_service_plan.practic-app-service-plan.id

  site_config {
    dotnet_framework_version = var.site_config.dotnet_framework_version
    scm_type = var.site_config.scm_type
  }
  connection_string {
    name = var.connection_string.name
    type = var.connection_string.type
    value = var.connection_string.value
  }
}