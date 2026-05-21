resource "azurerm_public_ip" "pip" {
  name                = "mahesh-appgw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["3"]
}