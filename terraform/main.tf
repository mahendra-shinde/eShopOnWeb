provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azdv_demo" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "azdv_demo" {
  name                = lower("AppServicePlan-${var.web_app_name}")
  location            = azurerm_resource_group.azdv_demo.location
  resource_group_name = azurerm_resource_group.azdv_demo.name
  sku_name            = "B1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "azdv_demo" {
  name                = var.web_app_name
  location            = azurerm_resource_group.azdv_demo.location
  resource_group_name = azurerm_resource_group.azdv_demo.name
  service_plan_id = azurerm_service_plan.azdv_demo.id

  site_config {
    
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "UseOnlyInMemoryDatabase" = "true"
  }
}

variable "web_app_name" {
  description = "The name of the web app"
  default     = "unique-web-app-name"
  // To override this variable using an environment variable, set TF_VAR_web_app_name
}

variable "sku" {
  description = "The SKU of the App Service Plan"
  default     = "B1"
  // To override this variable using an environment variable, set TF_VAR_sku
}

variable "location" {
  description = "The location of the resources"
  default     = "West Europe"
  // To override this variable using an environment variable, set TF_VAR_location
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "azdv_demo-resources"
  // To override this variable using an environment variable, set TF_VAR_resource_group_name
}
