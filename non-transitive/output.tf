output "vm_a_public_ip" {
  value = azurerm_public_ip.vm_a_pip.ip_address
}

output "vm_a_private_ip" {
  value = azurerm_network_interface.nic_a.private_ip_address
}

output "vm_b_private_ip" {
  value = azurerm_network_interface.nic_b.private_ip_address
}

output "vm_c_private_ip" {
  value = azurerm_network_interface.nic_c.private_ip_address
}