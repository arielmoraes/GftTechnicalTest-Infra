resource "azurerm_virtual_network" "vnet" {
  name                = "am-vnet-${local.version_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  tags = var.tags
}

resource "azurerm_subnet" "apimsubnet" {
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  name                  = "apim-subnet"
  address_prefixes      = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "akssubnet" {
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  name                  = "aks-subnet"
  address_prefixes      = ["10.0.2.0/24"]
}