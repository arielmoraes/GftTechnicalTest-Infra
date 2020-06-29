locals {
    version_name = "${var.environment}-${format("%03g", var.resource_counter)}"
}

resource "azurerm_resource_group" "rg" {
  name = "rs-gp-${local.version_name}"
  location = "brazilsouth"
}