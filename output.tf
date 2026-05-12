output "public_vm_ip" {
  value = azurerm_public_ip.public_vm_ip.ip_address
}

output "public_vm_name" {
  value = azurerm_linux_virtual_machine.public_vm.name
}

output "private_vm_private_ip" {
  value = azurerm_network_interface.private_nic.private_ip_address
}

output "nat_gateway_public_ip" {
  value = azurerm_public_ip.nat_pip.ip_address
}

output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}