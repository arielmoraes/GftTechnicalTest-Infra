resource "azurerm_kubernetes_cluster" "aks" {
  name                    = "am-aks-${local.version_name}"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  dns_prefix              = "am-aks-1"
  node_resource_group     = "am-aks-${local.version_name}-node-rg"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.akssubnet.id
  }

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.2.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr = "10.2.0.0/24"
  }

  role_based_access_control {
    enabled = true
  }

  service_principal {
    client_id     = var.aks_serviceprincipal["client_id"]
    client_secret = var.aks_serviceprincipal["client_secret"]
  }

  tags = var.tags
}