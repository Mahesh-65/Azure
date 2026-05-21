output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}

output "vmss_subnet_id" {
  value = azurerm_subnet.vmss.id
}