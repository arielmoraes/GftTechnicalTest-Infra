resource "azurerm_api_management" "apim" {
  name                 = "am-apim-${local.version_name}"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  publisher_name       = "Ariel Moraes"
  publisher_email      = "arielt.moraes@gmail.com"
  sku_name             = "Developer_1"
  virtual_network_type = "External"

  virtual_network_configuration {
    subnet_id = azurerm_subnet.apimsubnet.id
  }

  tags = var.tags
}

resource "azurerm_api_management_api" "apim_test_application_api" {
  name                  = "test-application-api"
  resource_group_name   = azurerm_resource_group.rg.name
  api_management_name   = azurerm_api_management.apim.name
  revision              = "1"
  display_name          = "Test Application API"
  path                  = "test-application"
  protocols             = ["http"]
  service_url           = "http://10.0.2.36"
  subscription_required = false
}

resource "azurerm_api_management_api_operation" "apim_test_application_api_operation" {
  operation_id        = "health-check"
  api_name            = azurerm_api_management_api.apim_test_application_api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Health Check"
  method              = "GET"
  url_template        = "/HealthCheck"
  description         = "Endpoint for checking health status"

  response {
    status_code = 200
  }
}