provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "apps-rg" {
  name     = var.resource_group_name
  location = "East US"
}

resource "azurerm_storage_account" "apps-strg" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = azurerm_resource_group.apps-rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_app_service_plan" "app-plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.apps-rg.location
  #resource_group_name = azurerm_resource_group.apps-rg.name
  resource_group_name      = var.resource_group_name

  sku {
    tier = var.app_service_plan_tier
    size = var.app_service_plan_size
  }
}

resource "azurerm_windows_function_app" "func-app" {
  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = azurerm_resource_group.apps-rg.location

  storage_account_name       = var.storage_account_name
  storage_account_access_key = azurerm_storage_account.apps-strg.primary_access_key
  service_plan_id            = azurerm_app_service_plan.app-plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {}
}

/***resource "azurerm_app_configuration" "app-conf" {
  name                = var.app_configuration_name
  resource_group_name = var.resource_group_name
  location            = azurerm_resource_group.apps-rg.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "role-assign" {
  principal_id         = azurerm_windows_function_app.func-app.identity[0].principal_id
  role_definition_name = "Reader"
  scope                = azurerm_app_configuration.app-conf.id 
  
} ***/
